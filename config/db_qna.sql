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
