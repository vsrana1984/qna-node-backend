-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 10, 2020 at 08:16 AM
-- Server version: 10.1.16-MariaDB
-- PHP Version: 5.6.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_qna`
--
CREATE DATABASE IF NOT EXISTS `db_qna` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `db_qna`;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `image` varchar(200) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `papers`
--

CREATE TABLE `papers` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `description` text,
  `created_by` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `papers`
--

INSERT INTO `papers` (`id`, `title`, `subject`, `description`, `created_by`, `createdAt`, `updatedAt`) VALUES
(1, 'Math Exam 27th Jul', 'Math', 'This exam for first grade student.Be prepare before 12''o clock 02 AUG', 1, '2020-07-28 04:57:57', '2020-07-30 06:23:42'),
(2, 'EVS Exam 5th AUG', 'EVS', 'This is for first grade. EVS will start 1 pm', 1, '2020-07-30 09:45:28', '2020-08-04 11:44:36'),
(3, 'GK EXAM 15th AUG', 'GK', 'This is first grade exam of GK', 1, '2020-08-05 14:29:00', '2020-08-05 14:29:00'),
(4, 'Math 09 Aug 2020', 'Math', 'This is for home work', 1, '2020-08-09 05:24:25', '2020-08-09 05:24:25');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `title` text,
  `paper_id` int(11) DEFAULT NULL,
  `option1` varchar(255) DEFAULT NULL,
  `option2` varchar(255) DEFAULT NULL,
  `option3` varchar(255) DEFAULT NULL,
  `option4` varchar(255) DEFAULT NULL,
  `mark` decimal(4,2) DEFAULT NULL,
  `answer` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `title`, `paper_id`, `option1`, `option2`, `option3`, `option4`, `mark`, `answer`, `createdAt`, `updatedAt`) VALUES
(1, '6 tens + 7 tens', 1, '110', '120', '130', '140', '5.00', '130', '2020-07-27 09:28:53', '2020-07-27 14:36:34'),
(2, '4 tens- 2 tens', 1, '20', '30', '35', '40', '5.00', '20', '2020-07-27 12:55:28', '2020-07-27 14:36:23'),
(3, '65 - 0', 1, '60', '65', '70', '80', '5.00', '65', '2020-07-27 12:55:56', '2020-07-27 14:35:58'),
(4, 'Which is the smaller number?', 1, '30', '29', '33', '35', '2.00', '29', '2020-07-28 04:50:21', '2020-07-28 05:08:54'),
(5, 'Which is living thing', 2, 'Chair', 'Table', 'Plant', 'River', '2.00', 'Plant', '2020-08-04 11:47:33', '2020-08-04 11:47:33'),
(6, 'What is capital of rajasthan', 2, 'Ajmer', 'Alwar', 'Jaipur', 'Kota', '2.00', 'Jaipur', '2020-08-05 09:14:17', '2020-08-05 09:14:17'),
(7, 'Sachin is best footballer of india ?', 3, 'True', 'False', '', '', '2.00', 'False', '2020-08-05 15:03:46', '2020-08-05 15:03:46'),
(8, '9 Tens + 3 Tens', 4, '110', '120', '100', '130', '2.00', '120', '2020-08-09 05:25:33', '2020-08-09 05:27:21'),
(9, 'Raj had 20 rupees his mother gave him 25 more .How much money did he has now', 4, '45', '35', '55', '60', '2.00', '45', '2020-08-09 05:27:14', '2020-08-09 05:27:14'),
(10, '65 + 0', 4, '64', '0', '65', '55', '1.00', '65', '2020-08-09 05:28:15', '2020-08-09 05:28:27'),
(11, '2 H + 2 Tens + 3 Ones', 4, '123', '223', '220', '210', '2.00', '223', '2020-08-09 05:29:55', '2020-08-09 05:31:37'),
(12, '  345\r\n+285', 4, '530', '620', '630', '520', '2.00', '630', '2020-08-09 05:31:09', '2020-08-09 05:31:09');

-- --------------------------------------------------------

--
-- Table structure for table `results`
--

CREATE TABLE `results` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `paper_id` int(11) DEFAULT NULL,
  `total_paper_mark` decimal(4,2) DEFAULT NULL,
  `total_user_mark` decimal(4,2) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `results`
--

INSERT INTO `results` (`id`, `user_id`, `paper_id`, `total_paper_mark`, `total_user_mark`, `createdAt`, `updatedAt`) VALUES
(1, 2, 1, '17.00', '12.00', '2020-08-04 06:36:32', '2020-08-04 06:36:32'),
(2, 2, 2, '4.00', '4.00', '2020-08-05 09:20:39', '2020-08-05 09:20:39'),
(3, 3, 3, '2.00', '2.00', '2020-08-06 05:14:13', '2020-08-06 05:14:13');

-- --------------------------------------------------------

--
-- Table structure for table `useranswers`
--

CREATE TABLE `useranswers` (
  `id` int(11) NOT NULL,
  `paper_id` int(11) DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `answer` varchar(255) DEFAULT NULL,
  `mark` decimal(4,2) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `useranswers`
--

INSERT INTO `useranswers` (`id`, `paper_id`, `question_id`, `user_id`, `answer`, `mark`, `createdAt`, `updatedAt`) VALUES
(1, 1, 1, 2, '130', '5.00', '2020-08-04 06:36:32', '2020-08-04 06:36:32'),
(2, 1, 2, 2, '30', '0.00', '2020-08-04 06:36:32', '2020-08-04 06:36:32'),
(3, 1, 3, 2, '65', '5.00', '2020-08-04 06:36:32', '2020-08-04 06:36:32'),
(4, 1, 4, 2, '29', '2.00', '2020-08-04 06:36:32', '2020-08-04 06:36:32'),
(5, 2, 5, 2, 'Plant', '2.00', '2020-08-05 09:20:39', '2020-08-05 09:20:39'),
(6, 2, 6, 2, 'Jaipur', '2.00', '2020-08-05 09:20:39', '2020-08-05 09:20:39'),
(7, 3, 7, 3, 'False', '2.00', '2020-08-06 05:14:13', '2020-08-06 05:14:13');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `firstname` varchar(200) DEFAULT NULL,
  `lastname` varchar(200) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `type` varchar(100) NOT NULL DEFAULT 'user',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `username`, `password`, `type`, `createdAt`, `updatedAt`) VALUES
(1, 'Vijender', 'Rana', 'vsrana1984@gmail.com', 'vrana', '$2a$10$VNP.wKsGDdUnwkGSlhtnZeyI9PvoZSbD1iAAyXA5TwmfQmzglSvlS', 'admin', '2020-07-27 05:40:21', '2020-07-28 12:13:50'),
(2, 'Vaishnavi', 'Rana', 'vaishnavi.rana@gmail.com', 'gunnu', '$2a$10$IGDFQ1o6KC9//v0UCqAOyu8zOySBqwrcZoY43inYwLOHrASi.vxWK', 'user', '2020-07-28 11:12:49', '2020-07-28 12:02:57'),
(3, 'Shirsti', 'Rana', 'shirsti@google.com', 'shirsti', '$2a$10$oJINexuO8jgPdpaovIR//.OIDSZHdR/lK8bZlREWFOoPXhlOf8J1y', 'user', '2020-08-06 05:13:47', '2020-08-06 05:13:47');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `papers`
--
ALTER TABLE `papers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `results`
--
ALTER TABLE `results`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `useranswers`
--
ALTER TABLE `useranswers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `paper_id` (`paper_id`),
  ADD KEY `question_id` (`question_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `papers`
--
ALTER TABLE `papers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `results`
--
ALTER TABLE `results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `useranswers`
--
ALTER TABLE `useranswers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `useranswers`
--
ALTER TABLE `useranswers`
  ADD CONSTRAINT `useranswers_ibfk_1` FOREIGN KEY (`paper_id`) REFERENCES `papers` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `useranswers_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `useranswers_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
