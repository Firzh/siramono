<?php
// Panggil file koneksi.php dari direktori CRUD
require_once 'CRUD/koneksi.php'; // Sesuaikan path jika direktori root berbeda

// Ambil data dari form
$username = trim($_POST['username']);
$nama = trim($_POST['nama']);
$email = trim($_POST['email']);
$password1 = $_POST['password1'];
$password2 = $_POST['password2'];
$terms = isset($_POST['terms']) ? true : false;

// Validasi input
$errors = [];

if (strlen($username) < 3) {
  $errors[] = "Username minimal 3 karakter.";
}

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
  $errors[] = "Format email tidak valid.";
}

if (strlen($password1) < 6) {
  $errors[] = "Password minimal 6 karakter.";
}

if ($password1 !== $password2) {
  $errors[] = "Password dan konfirmasi tidak cocok.";
}

if (!$terms) {
  $errors[] = "Anda harus menyetujui syarat & ketentuan.";
}

// === Pengecekan Duplikasi Data ===
// Pengecekan Username
$stmt_check_username = $conn->prepare("SELECT id FROM users WHERE username = ?");
$stmt_check_username->bind_param("s", $username);
$stmt_check_username->execute();
$stmt_check_username->store_result();
if ($stmt_check_username->num_rows > 0) {
    $errors[] = "Username sudah terdaftar. Silakan gunakan username lain.";
}
$stmt_check_username->close();

// Pengecekan Email
$stmt_check_email = $conn->prepare("SELECT id FROM users WHERE email = ?");
$stmt_check_email->bind_param("s", $email);
$stmt_check_email->execute();
$stmt_check_email->store_result();
if ($stmt_check_email->num_rows > 0) {
    $errors[] = "Email sudah terdaftar. Silakan gunakan email lain.";
}
$stmt_check_email->close();
// === Akhir Pengecekan Duplikasi Data ===


// Function to generate the HTML output for messages
function generateMessagePage($messages, $isError = true, $linkText = 'Kembali', $linkHref = 'register.html') {
    $colorClass = $isError ? 'text-red-600' : 'text-green-600';
    $bgColorClass = $isError ? 'bg-red-100' : 'bg-green-100';
    ?>
    <!DOCTYPE html>
    <html lang="id">
    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>Siramono - Notifikasi</title>
      <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="min-h-screen flex items-center justify-center font-sans relative bg-cover bg-center"
      style="background-image: url('./img/bgregister.png');">

      <div class="w-full max-w-md px-4 py-16 bg-white/60 rounded-3xl z-10 text-center">
        <h2 class="text-4xl font-bold text-[#4A5E20] text-center mb-6">Pemberitahuan</h2>
        <div class="p-4 rounded-lg <?php echo $bgColorClass; ?> mb-6">
          <?php foreach ($messages as $message): ?>
            <p class="font-semibold <?php echo $colorClass; ?> mb-2"><?php echo $message; ?></p>
          <?php endforeach; ?>
        </div>
        <p class="text-center text-sm text-green-700">
          <a href="<?php echo $linkHref; ?>" class="font-bold text-black hover:underline"><?php echo $linkText; ?></a>
        </p>
      </div>
    </body>
    </html>
    <?php
    exit();
}

if (!empty($errors)) {
  generateMessagePage($errors, true, 'Kembali ke Registrasi', 'register.html');
}

// Hash password
$hashedPassword = password_hash($password1, PASSWORD_DEFAULT);

// Simpan ke database
// Pastikan tabel users sudah memiliki kolom 'nama'
$stmt = $conn->prepare("INSERT INTO users (username, nama, email, password) VALUES (?, ?, ?, ?)");
$stmt->bind_param("ssss", $username, $nama, $email, $hashedPassword);

if ($stmt->execute()) {
  generateMessagePage(["Registrasi berhasil!"], false, 'Login sekarang', 'login.html');
} else {
  // Ini akan menangkap error database lainnya selain duplikasi yang sudah dicek di atas
  generateMessagePage(["Gagal menyimpan data: " . $stmt->error], true, 'Kembali ke Registrasi', 'register.html');
}

$stmt->close();
?>