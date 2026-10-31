-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 31, 2026 at 11:09 AM
-- Server version: 10.11.16-MariaDB
-- PHP Version: 8.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tenangbos`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendances`
--

CREATE TABLE `attendances` (
  `id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(10) UNSIGNED NOT NULL,
  `outlet_id` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `status` enum('hadir','terlambat','alpha','izin','cuti') NOT NULL DEFAULT 'hadir',
  `check_in` time DEFAULT NULL,
  `check_out` time DEFAULT NULL,
  `late_minutes` int(11) NOT NULL DEFAULT 0,
  `notes` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attendances`
--

INSERT INTO `attendances` (`id`, `employee_id`, `outlet_id`, `date`, `status`, `check_in`, `check_out`, `late_minutes`, `notes`, `created_at`) VALUES
(14, 21, 2, '2026-10-29', 'hadir', '01:12:49', NULL, 0, NULL, '2026-10-28 18:12:49'),
(15, 22, 2, '2026-10-29', 'hadir', '08:05:50', '08:06:38', 0, NULL, '2026-10-29 01:05:50'),
(16, 21, 2, '2026-10-31', 'hadir', '16:09:17', NULL, 0, NULL, '2026-10-31 09:09:17');

-- --------------------------------------------------------

--
-- Table structure for table `checklist_items`
--

CREATE TABLE `checklist_items` (
  `id` int(11) NOT NULL,
  `template_id` int(11) NOT NULL,
  `task_text` varchar(255) NOT NULL,
  `assigned_to` text DEFAULT NULL,
  `unit` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `checklist_templates`
--

CREATE TABLE `checklist_templates` (
  `id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `shift` enum('Pagi','Siang','Malam') NOT NULL,
  `outlet_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int(10) UNSIGNED NOT NULL,
  `outlet_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `position` varchar(80) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `join_date` date DEFAULT NULL,
  `score` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `default_shift_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `outlet_id`, `name`, `position`, `photo`, `phone`, `password`, `join_date`, `score`, `is_active`, `created_at`, `updated_at`, `default_shift_id`) VALUES
(21, 2, 'Alvin', 'Manager', NULL, '', NULL, '2026-10-29', 0, 1, '2026-10-28 18:12:33', '2026-10-31 09:07:12', 4),
(22, 2, 'Naya', 'Kasir', NULL, '088389099000', NULL, '2026-10-29', 0, 1, '2026-10-29 01:05:18', '2026-10-31 09:07:15', 5);

-- --------------------------------------------------------

--
-- Table structure for table `incidents`
--

CREATE TABLE `incidents` (
  `id` int(10) UNSIGNED NOT NULL,
  `outlet_id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(10) UNSIGNED DEFAULT NULL,
  `title` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `severity` enum('ringan','sedang','berat') NOT NULL DEFAULT 'ringan',
  `status` enum('aktif','selesai') NOT NULL DEFAULT 'aktif',
  `occurred_at` datetime NOT NULL,
  `resolved_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `outlets`
--

CREATE TABLE `outlets` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `code` varchar(20) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `status` enum('normal','perlu_perhatian','bermasalah') NOT NULL DEFAULT 'normal',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `latitude` varchar(20) DEFAULT NULL,
  `longitude` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `outlets`
--

INSERT INTO `outlets` (`id`, `name`, `code`, `address`, `phone`, `status`, `is_active`, `created_at`, `updated_at`, `latitude`, `longitude`) VALUES
(2, 'Outlet BSD', 'BSD', 'Jl. BSD Boulevard, Tangerang', NULL, 'normal', 1, '2026-10-27 00:45:03', '2026-10-27 00:45:03', NULL, NULL),
(3, 'Outlet Kelapa Gading', 'KGD', 'Jl. Boulevard Gading, Jakarta', NULL, 'normal', 1, '2026-10-27 00:45:03', '2026-10-27 00:45:03', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `schedules`
--

CREATE TABLE `schedules` (
  `id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `shift_id` int(11) DEFAULT NULL,
  `status` enum('masuk','libur','sakit','izin') DEFAULT 'masuk'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `schedules`
--

INSERT INTO `schedules` (`id`, `employee_id`, `date`, `shift_id`, `status`) VALUES
(1, 5, '2026-10-31', NULL, 'libur'),
(2, 6, '2026-10-31', NULL, 'libur'),
(3, 7, '2026-10-31', NULL, 'libur'),
(4, 8, '2026-10-27', NULL, 'sakit'),
(5, 6, '2026-10-28', 7, 'masuk'),
(6, 6, '2026-10-29', 7, 'masuk'),
(7, 5, '2026-10-26', NULL, 'libur'),
(9, 9, '2026-10-28', NULL, 'libur'),
(11, 10, '2026-10-30', 7, 'masuk'),
(12, 14, '2026-10-31', NULL, 'libur'),
(13, 21, '2026-10-31', 6, 'masuk');

-- --------------------------------------------------------

--
-- Table structure for table `shifts`
--

CREATE TABLE `shifts` (
  `id` int(11) NOT NULL,
  `outlet_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shifts`
--

INSERT INTO `shifts` (`id`, `outlet_id`, `name`, `start_time`, `end_time`) VALUES
(4, 2, 'Pagi', '09:00:00', '10:00:00'),
(5, 2, 'Siang', '11:00:00', '12:00:00'),
(6, 2, 'Malam', '01:00:00', '02:00:00'),
(7, 1, 'Pagi', '08:00:00', '16:00:00'),
(8, 1, 'Siang', '12:00:00', '20:00:00'),
(9, 1, 'Malam', '16:00:00', '00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `sops`
--

CREATE TABLE `sops` (
  `id` int(10) UNSIGNED NOT NULL,
  `outlet_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(80) DEFAULT NULL,
  `is_done` tinyint(1) NOT NULL DEFAULT 0,
  `due_date` date DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sops`
--

INSERT INTO `sops` (`id`, `outlet_id`, `title`, `description`, `category`, `is_done`, `due_date`, `completed_at`, `created_at`, `updated_at`) VALUES
(3, 2, 'Checklist kebersihan', 'Sapu, pel, dan buang sampah', 'Harian', 1, '2026-10-26', NULL, '2026-10-27 00:45:03', '2026-10-27 00:45:03'),
(4, 3, 'Checklist stok', 'Cek stok bahan baku', 'Harian', 1, '2026-10-26', NULL, '2026-10-27 00:45:03', '2026-10-27 00:45:03');

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `id` int(10) UNSIGNED NOT NULL,
  `outlet_id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `status` enum('menunggu','selesai') DEFAULT 'menunggu',
  `created_at` date NOT NULL,
  `due_date` date DEFAULT NULL,
  `points` int(11) DEFAULT 10,
  `target_type` enum('semua','karyawan','shift') DEFAULT 'karyawan',
  `target_shift_id` int(11) DEFAULT NULL,
  `quality` enum('excellent','baik','kurang') DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trainings`
--

CREATE TABLE `trainings` (
  `id` int(10) UNSIGNED NOT NULL,
  `outlet_id` int(10) UNSIGNED DEFAULT NULL,
  `title` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `status` enum('aktif','selesai') NOT NULL DEFAULT 'aktif',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `training_participants`
--

CREATE TABLE `training_participants` (
  `id` int(10) UNSIGNED NOT NULL,
  `training_id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(10) UNSIGNED NOT NULL,
  `status` enum('terdaftar','selesai') NOT NULL DEFAULT 'terdaftar',
  `completed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('owner','admin_outlet') NOT NULL DEFAULT 'owner',
  `outlet_id` int(10) UNSIGNED DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `outlet_id`, `is_active`, `created_at`, `updated_at`) VALUES
(2, 'Owner TenangBos', 'owner@tenangbos.test', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'owner', NULL, 1, '2026-10-27 14:28:00', '2026-10-27 14:28:00');

-- --------------------------------------------------------

--
-- Table structure for table `weekly_scores`
--

CREATE TABLE `weekly_scores` (
  `id` int(10) UNSIGNED NOT NULL,
  `week_start` date NOT NULL,
  `type` enum('employee','outlet') NOT NULL,
  `ref_id` int(10) UNSIGNED NOT NULL,
  `score` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `weekly_scores`
--

INSERT INTO `weekly_scores` (`id`, `week_start`, `type`, `ref_id`, `score`, `created_at`) VALUES
(1, '2026-10-26', 'employee', 4, 95, '2026-10-27 00:45:03'),
(2, '2026-10-26', 'employee', 6, 88, '2026-10-27 00:45:03'),
(3, '2026-10-26', 'employee', 5, 85, '2026-10-27 00:45:03'),
(4, '2026-10-26', 'employee', 7, 84, '2026-10-27 00:45:03'),
(5, '2026-10-26', 'employee', 2, 80, '2026-10-27 00:45:03'),
(6, '2026-10-26', 'employee', 1, 78, '2026-10-27 00:45:03'),
(7, '2026-10-26', 'employee', 3, 72, '2026-10-27 00:45:03'),
(8, '2026-10-26', 'outlet', 1, 88, '2026-10-27 00:45:03'),
(9, '2026-10-26', 'outlet', 2, 86, '2026-10-27 00:45:03'),
(10, '2026-10-26', 'outlet', 3, 84, '2026-10-27 00:45:03'),
(11, '2026-10-26', 'outlet', 4, 70, '2026-10-27 00:45:03');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendances`
--
ALTER TABLE `attendances`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_att_employee_date` (`employee_id`,`date`),
  ADD KEY `idx_att_date` (`date`),
  ADD KEY `idx_att_outlet_date` (`outlet_id`,`date`),
  ADD KEY `idx_att_status` (`status`);

--
-- Indexes for table `checklist_items`
--
ALTER TABLE `checklist_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `template_id` (`template_id`);

--
-- Indexes for table `checklist_templates`
--
ALTER TABLE `checklist_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_employees_outlet` (`outlet_id`);

--
-- Indexes for table `incidents`
--
ALTER TABLE `incidents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_inc_outlet` (`outlet_id`),
  ADD KEY `fk_inc_employee` (`employee_id`),
  ADD KEY `idx_inc_status` (`status`),
  ADD KEY `idx_inc_occurred` (`occurred_at`);

--
-- Indexes for table `outlets`
--
ALTER TABLE `outlets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `schedules`
--
ALTER TABLE `schedules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shifts`
--
ALTER TABLE `shifts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sops`
--
ALTER TABLE `sops`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_sop_outlet_done` (`outlet_id`,`is_done`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `outlet_id` (`outlet_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `trainings`
--
ALTER TABLE `trainings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_training_outlet` (`outlet_id`),
  ADD KEY `idx_training_status` (`status`);

--
-- Indexes for table `training_participants`
--
ALTER TABLE `training_participants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_tp` (`training_id`,`employee_id`),
  ADD KEY `fk_tp_employee` (`employee_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `fk_users_outlet` (`outlet_id`);

--
-- Indexes for table `weekly_scores`
--
ALTER TABLE `weekly_scores`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_weekly` (`week_start`,`type`,`ref_id`),
  ADD KEY `idx_weekly_type` (`type`,`week_start`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendances`
--
ALTER TABLE `attendances`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `checklist_items`
--
ALTER TABLE `checklist_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `checklist_templates`
--
ALTER TABLE `checklist_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `incidents`
--
ALTER TABLE `incidents`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `outlets`
--
ALTER TABLE `outlets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `schedules`
--
ALTER TABLE `schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `shifts`
--
ALTER TABLE `shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `sops`
--
ALTER TABLE `sops`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `trainings`
--
ALTER TABLE `trainings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `training_participants`
--
ALTER TABLE `training_participants`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `weekly_scores`
--
ALTER TABLE `weekly_scores`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendances`
--
ALTER TABLE `attendances`
  ADD CONSTRAINT `fk_att_employee` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_att_outlet` FOREIGN KEY (`outlet_id`) REFERENCES `outlets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `checklist_items`
--
ALTER TABLE `checklist_items`
  ADD CONSTRAINT `checklist_items_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `checklist_templates` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `fk_employees_outlet` FOREIGN KEY (`outlet_id`) REFERENCES `outlets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `incidents`
--
ALTER TABLE `incidents`
  ADD CONSTRAINT `fk_inc_employee` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_inc_outlet` FOREIGN KEY (`outlet_id`) REFERENCES `outlets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sops`
--
ALTER TABLE `sops`
  ADD CONSTRAINT `fk_sop_outlet` FOREIGN KEY (`outlet_id`) REFERENCES `outlets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tasks`
--
ALTER TABLE `tasks`
  ADD CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`outlet_id`) REFERENCES `outlets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tasks_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `trainings`
--
ALTER TABLE `trainings`
  ADD CONSTRAINT `fk_training_outlet` FOREIGN KEY (`outlet_id`) REFERENCES `outlets` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `training_participants`
--
ALTER TABLE `training_participants`
  ADD CONSTRAINT `fk_tp_employee` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tp_training` FOREIGN KEY (`training_id`) REFERENCES `trainings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_outlet` FOREIGN KEY (`outlet_id`) REFERENCES `outlets` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
