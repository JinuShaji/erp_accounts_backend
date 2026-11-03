-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 03, 2026 at 08:19 AM
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
-- Database: `erp_accounting`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `account_code` varchar(20) NOT NULL,
  `name` varchar(120) NOT NULL,
  `type` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `account_code`, `name`, `type`, `created_at`) VALUES
(1, '1000', 'Cash', 'asset', '2026-11-03 06:59:49'),
(2, '1010', 'Bank', 'asset', '2026-11-03 06:59:49'),
(3, '1100', 'Accounts Receivable', 'asset', '2026-11-03 06:59:49'),
(4, '2100', 'GST Payable', 'liability', '2026-11-03 06:59:49'),
(5, '3000', 'Owner\'s Capital', 'equity', '2026-11-03 06:59:49'),
(6, '4000', 'Sales Income', 'income', '2026-11-03 06:59:49'),
(7, '5000', 'General Expense', 'expense', '2026-11-03 06:59:49');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phn` varchar(13) NOT NULL,
  `gst_no` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `name`, `email`, `phn`, `gst_no`) VALUES
(1, 'ABC Traders', 'abc@gmail.com', '9876543210', 32);

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `id` int(11) NOT NULL,
  `unique_invoice_no` varchar(50) NOT NULL,
  `cusomer_id` int(11) NOT NULL,
  `invoice_date` date NOT NULL,
  `due_date` date NOT NULL,
  `status` varchar(11) NOT NULL COMMENT '1-draft,2-issued,3-party_paid,4-paid',
  `subtotal` decimal(15,2) DEFAULT NULL,
  `tax_amount` decimal(15,2) DEFAULT NULL,
  `total` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`id`, `unique_invoice_no`, `cusomer_id`, `invoice_date`, `due_date`, `status`, `subtotal`, `tax_amount`, `total`) VALUES
(1, 'INV-00000001', 1, '2026-11-03', '2026-11-10', 'draft', 12000.00, 2160.00, 14160.00),
(2, 'INV-00000002', 1, '2026-11-03', '2026-11-10', 'issued', 12000.00, 2160.00, 14160.00),
(9, 'INV-00000009', 1, '2026-11-03', '2026-11-17', 'issued', 0.00, 0.00, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `invoice_line_items`
--

CREATE TABLE `invoice_line_items` (
  `id` int(11) NOT NULL,
  `description` text NOT NULL,
  `quantity` decimal(15,3) DEFAULT NULL,
  `unit_price` decimal(15,2) DEFAULT NULL,
  `tax_rate` decimal(5,2) DEFAULT NULL,
  `line_total` decimal(15,2) DEFAULT NULL,
  `invoice_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invoice_line_items`
--

INSERT INTO `invoice_line_items` (`id`, `description`, `quantity`, `unit_price`, `tax_rate`, `line_total`, `invoice_id`) VALUES
(1, 'Web Development', 2.000, 5000.00, 18.00, 11800.00, 2),
(2, 'Maintenance', 1.000, 2000.00, 18.00, 2360.00, 2),
(3, 'gfgffg', 1.000, 0.00, 0.00, 0.00, 9);

-- --------------------------------------------------------

--
-- Table structure for table `journal_entries`
--

CREATE TABLE `journal_entries` (
  `id` bigint(20) NOT NULL,
  `entry_date` date NOT NULL,
  `reference_type` varchar(20) NOT NULL,
  `reference_id` bigint(20) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'posted',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ;

--
-- Dumping data for table `journal_entries`
--

INSERT INTO `journal_entries` (`id`, `entry_date`, `reference_type`, `reference_id`, `description`, `status`, `created_at`) VALUES
(2, '2026-11-03', 'invoice', 2, 'Invoice issued: 0', 'posted', '2026-11-03 07:03:42'),
(3, '2026-11-03', 'payment', 1, 'Payment received for invoice 2', 'posted', '2026-11-03 07:04:33');

-- --------------------------------------------------------

--
-- Table structure for table `journal_entry_lines`
--

CREATE TABLE `journal_entry_lines` (
  `id` bigint(20) NOT NULL,
  `journal_entry_id` bigint(20) NOT NULL,
  `account_id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `debit` decimal(15,2) NOT NULL DEFAULT 0.00,
  `credit` decimal(15,2) NOT NULL DEFAULT 0.00
) ;

--
-- Dumping data for table `journal_entry_lines`
--

INSERT INTO `journal_entry_lines` (`id`, `journal_entry_id`, `account_id`, `description`, `debit`, `credit`) VALUES
(3, 2, 3, 'Accounts receivable for 0', 14160.00, 0.00),
(4, 2, 6, 'Sales revenue for 0', 0.00, 12000.00),
(5, 2, 4, 'Tax payable for 0', 0.00, 2160.00),
(6, 3, 2, 'Funds received by Bank transfer', 5000.00, 0.00),
(7, 3, 3, 'Accounts receivable settled for invoice 2', 0.00, 5000.00);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `cusomer_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `amount` decimal(15,2) DEFAULT NULL,
  `payment_method` varchar(30) NOT NULL,
  `reference_no` varchar(100) DEFAULT NULL,
  `invoice_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `cusomer_id`, `date`, `amount`, `payment_method`, `reference_no`, `invoice_id`) VALUES
(1, 1, '2026-11-03', 5000.00, 'Bank transfer', NULL, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_code` (`account_code`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_invoice_unique_no` (`unique_invoice_no`);

--
-- Indexes for table `invoice_line_items`
--
ALTER TABLE `invoice_line_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `journal_entries`
--
ALTER TABLE `journal_entries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_journal_source` (`reference_type`,`reference_id`);

--
-- Indexes for table `journal_entry_lines`
--
ALTER TABLE `journal_entry_lines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_journal_lines_entry` (`journal_entry_id`),
  ADD KEY `fk_journal_lines_account` (`account_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `invoice_line_items`
--
ALTER TABLE `invoice_line_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `journal_entries`
--
ALTER TABLE `journal_entries`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `journal_entry_lines`
--
ALTER TABLE `journal_entry_lines`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `journal_entry_lines`
--
ALTER TABLE `journal_entry_lines`
  ADD CONSTRAINT `fk_journal_lines_account` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  ADD CONSTRAINT `fk_journal_lines_entry` FOREIGN KEY (`journal_entry_id`) REFERENCES `journal_entries` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
