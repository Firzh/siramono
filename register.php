<?php
// Koneksi ke database
require_once 'CRUD/koneksi.php';

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

if (!empty($errors)) {
  foreach ($errors as $error) {
    echo "<p style='color:red;'>$error</p>";
  }
  echo "<p><a href='register.html'>Kembali</a></p>";
  exit();
}

// Hash password
$hashedPassword = password_hash($password1, PASSWORD_DEFAULT);

// Simpan ke database
$stmt = $conn->prepare("INSERT INTO users (username, nama, email, password) VALUES (?, ?, ?, ?)");
$stmt->bind_param("ssss", $username, $nama, $email, $hashedPassword);

if ($stmt->execute()) {
  echo "<p>Registrasi berhasil! <a href='login.html'>Login sekarang</a></p>";
} else {
  echo "<p style='color:red;'>Gagal menyimpan data: " . $stmt->error . "</p>";
}

$stmt->close();
