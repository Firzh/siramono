-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 14 Apr 2025 pada 10.07
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `siramono`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `penyiraman`
--

CREATE TABLE `penyiraman` (
  `id_penyiraman` int(11) NOT NULL,
  `id_tanaman` int(11) DEFAULT NULL,
  `waktu_siram` datetime DEFAULT current_timestamp(),
  `jumlah_air` int(11) DEFAULT NULL COMMENT 'Jumlah air yang diberikan (ml)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `sensor`
--

CREATE TABLE `sensor` (
  `id_sensor` int(11) NOT NULL,
  `id_tanaman` int(11) DEFAULT NULL,
  `kelembaban` int(11) DEFAULT NULL COMMENT 'Tingkat kelembaban tanah dalam persen',
  `waktu_update` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tanaman`
--

CREATE TABLE `tanaman` (
  `id_tanaman` int(11) NOT NULL,
  `nama_tanaman` varchar(100) NOT NULL,
  `jenis` varchar(50) DEFAULT NULL,
  `lokasi` varchar(100) DEFAULT NULL,
  `tanggal_tanam` date DEFAULT NULL,
  `kebutuhan_air` int(11) DEFAULT NULL COMMENT 'Jumlah ml air per hari',
  `status` varchar(20) DEFAULT 'Sehat' COMMENT 'Sehat, Layu, atau Mati'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_tanaman`
--

CREATE TABLE `tb_tanaman` (
  `id_tanaman` int(11) NOT NULL,
  `nama_tanaman` varchar(100) NOT NULL,
  `jenis_tanaman` enum('Tanaman Hias Daun','Tanaman Hias Bunga','Tanaman Hias Gantung','Tanaman Hias Air','Tanaman Hias Sukulen dan Kaktus') NOT NULL,
  `status_penyiraman` enum('Otomatis','Manual') NOT NULL,
  `waktu_terakhir` timestamp NOT NULL DEFAULT current_timestamp(),
  `kode_tanaman` varchar(20) NOT NULL,
  `tanggal_tanam` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `tb_tanaman`
--

INSERT INTO `tb_tanaman` (`id_tanaman`, `nama_tanaman`, `jenis_tanaman`, `status_penyiraman`, `waktu_terakhir`, `kode_tanaman`, `tanggal_tanam`) VALUES
(4, 'heheheh', 'Tanaman Hias Bunga', 'Otomatis', '2025-03-23 18:51:36', 'T001', '2025-03-24'),
(5, 'haloo', 'Tanaman Hias Daun', 'Manual', '2025-03-23 18:51:47', 'T002', '2025-03-05'),
(6, 'xixixixi', 'Tanaman Hias Daun', 'Manual', '2025-03-23 18:51:59', 'T003', '2025-03-01'),
(7, 'hiihi', 'Tanaman Hias Sukulen dan Kaktus', 'Otomatis', '2025-03-23 18:55:17', 'T004', '2025-02-27'),
(9, 'bunga', 'Tanaman Hias Bunga', 'Otomatis', '2025-03-24 03:29:13', 'T005', '2025-04-03'),
(10, 'hai', 'Tanaman Hias Daun', 'Otomatis', '2025-03-24 03:47:26', 'T006', '2025-03-14');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `nama` varchar(100) DEFAULT NULL, -- Kolom 'nama' ditambahkan di sini
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`) VALUES
(3, 'haloo', 'malas@gmail.com', '$2y$10$8pI1bQXJV5AGxKKX/ZrNBeODLn6W3I8b5zgkPC2D/p1U.3TKs2yPa');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `penyiraman`
--
ALTER TABLE `penyiraman`
  ADD PRIMARY KEY (`id_penyiraman`),
  ADD KEY `id_tanaman` (`id_tanaman`);

--
-- Indeks untuk tabel `sensor`
--
ALTER TABLE `sensor`
  ADD PRIMARY KEY (`id_sensor`),
  ADD KEY `id_tanaman` (`id_tanaman`);

--
-- Indeks untuk tabel `tanaman`
--
ALTER TABLE `tanaman`
  ADD PRIMARY KEY (`id_tanaman`);

--
-- Indeks untuk tabel `tb_tanaman`
--
ALTER TABLE `tb_tanaman`
  ADD PRIMARY KEY (`id_tanaman`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `penyiraman`
--
ALTER TABLE `penyiraman`
  MODIFY `id_penyiraman` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `sensor`
--
ALTER TABLE `sensor`
  MODIFY `id_sensor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tanaman`
--
ALTER TABLE `tanaman`
  MODIFY `id_tanaman` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tb_tanaman`
--
ALTER TABLE `tb_tanaman`
  MODIFY `id_tanaman` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `penyiraman`
--
ALTER TABLE `penyiraman`
  ADD CONSTRAINT `penyiraman_ibfk_1` FOREIGN KEY (`id_tanaman`) REFERENCES `tanaman` (`id_tanaman`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `sensor`
--
ALTER TABLE `sensor`
  ADD CONSTRAINT `sensor_ibfk_1` FOREIGN KEY (`id_tanaman`) REFERENCES `tanaman` (`id_tanaman`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;