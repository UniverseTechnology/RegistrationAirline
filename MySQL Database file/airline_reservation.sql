-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 12, 2023 at 04:19 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `airline_reservation`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetFlightStatistics` (IN `j_date` DATE)   BEGIN
 select flight_no,departure_date,IFNULL(no_of_passengers, 0) as no_of_passengers,total_capacity from (
select f.flight_no,f.departure_date,sum(t.no_of_passengers) as no_of_passengers,j.total_capacity 
from flight_details f left join ticket_details t 
on t.booking_status='CONFIRMED' 
and t.flight_no=f.flight_no 
and f.departure_date=t.journey_date 
inner join jet_details j on j.jet_id=f.jet_id
group by flight_no,journey_date) k where departure_date=j_date;
 END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` varchar(20) NOT NULL,
  `pwd` varchar(30) DEFAULT NULL,
  `staff_id` varchar(20) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `email` varchar(35) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `pwd`, `staff_id`, `name`, `email`) VALUES
('mahato', 'universe', '101', 'Ratish Mahato', 'mahatoratish7290@gmail.com');


-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` varchar(20) NOT NULL,
  `pwd` varchar(255) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `email` varchar(35) DEFAULT NULL,
  `phone_no` varchar(15) DEFAULT NULL,
  `address` varchar(35) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `pwd`, `name`, `email`, `phone_no`, `address`) VALUES
('12345', 'mandal@123', 'pursottam', 'purushmandal519@gmail.com', '9848906949', 'ramgopalpur'),
('ratish', 'passpass', 'ratish mahato', 'mahatoratish@gmail.com', '9845713736', '#381, 1st E Main,');

-- --------------------------------------------------------

--
-- Table structure for table `flight_details`
--

CREATE TABLE `flight_details` (
  `flight_no` varchar(10) NOT NULL,
  `from_city` varchar(20) DEFAULT NULL,
  `to_city` varchar(20) DEFAULT NULL,
  `departure_date` date NOT NULL,
  `arrival_date` date DEFAULT NULL,
  `departure_time` time DEFAULT NULL,
  `arrival_time` time DEFAULT NULL,
  `seats_economy` int(5) DEFAULT NULL,
  `seats_business` int(5) DEFAULT NULL,
  `price_economy` int(10) DEFAULT NULL,
  `price_business` int(10) DEFAULT NULL,
  `jet_id` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `flight_details`
--

INSERT INTO `flight_details` (`flight_no`, `from_city`, `to_city`, `departure_date`, `arrival_date`, `departure_time`, `arrival_time`, `seats_economy`, `seats_business`, `price_economy`, `price_business`, `jet_id`) VALUES
('a500', 'kathamdu', 'doha', '2023-06-03', '2023-06-03', '17:30:00', '22:30:00', 150, 100, 2500, 25000, 'a500'),
('AA101', 'Kathmandu', 'mumbai', '2023-06-01', '2023-06-02', '21:00:00', '01:00:00', 195, 96, 5000, 7500, '10001'),
('AA102', 'KATHMANDU', 'mumbai', '2023-06-03', '2023-06-03', '10:00:00', '12:00:00', 200, 73, 2500, 3000, '10002'),
('AA103', 'kathmandu', 'chennai', '2023-06-03', '2023-06-03', '17:00:00', '17:45:00', 150, 75, 1200, 1500, '10004'),
('AA104', 'kathmandu', 'mysore', '2023-06-04', '2023-06-04', '09:00:00', '09:17:00', 37, 4, 500, 750, '10003'),
('AA106', 'kathmandu', 'hyderabad', '2023-06-01', '2023-06-01', '13:00:00', '14:00:00', 150, 75, 3000, 3750, '10004'),
('aa5000', 'Kathmandu', 'mumbai', '2023-06-09', '2023-06-09', '10:30:00', '16:20:00', 200, 150, 12000, 300000, 'aa5000');

-- --------------------------------------------------------

--
-- Table structure for table `frequent_flier_details`
--

CREATE TABLE `frequent_flier_details` (
  `frequent_flier_no` varchar(20) NOT NULL,
  `customer_id` varchar(20) DEFAULT NULL,
  `mileage` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `frequent_flier_details`
--

INSERT INTO `frequent_flier_details` (`frequent_flier_no`, `customer_id`, `mileage`) VALUES
('10001000', 'mandal', 375),
('20002000', 'ratish', 150);

-- --------------------------------------------------------

--
-- Table structure for table `jet_details`
--

CREATE TABLE `jet_details` (
  `jet_id` varchar(10) NOT NULL,
  `jet_type` varchar(20) DEFAULT NULL,
  `total_capacity` int(5) DEFAULT NULL,
  `active` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `jet_details`
--

INSERT INTO `jet_details` (`jet_id`, `jet_type`, `total_capacity`, `active`) VALUES
('10001', 'Dreamliner', 300, 'Yes'),
('10002', 'Airbus A380', 275, 'Yes'),
('10003', 'ATR', 50, 'Yes'),
('10004', 'Boeing 737', 225, 'Yes'),
('10007', 'Test_Model', 250, 'Yes'),
('a500', 'airbus', 250, 'Yes'),
('aa5000', 'AIRBUS', 350, 'Yes');

-- --------------------------------------------------------

--
-- Table structure for table `passengers`
--

CREATE TABLE `passengers` (
  `passenger_id` int(10) NOT NULL,
  `pnr` varchar(15) NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  `age` int(3) DEFAULT NULL,
  `gender` varchar(8) DEFAULT NULL,
  `meal_choice` varchar(5) DEFAULT NULL,
  `frequent_flier_no` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `passengers`
--

INSERT INTO `passengers` (`passenger_id`, `pnr`, `name`, `age`, `gender`, `meal_choice`, `frequent_flier_no`) VALUES
(1, '1379710', 'ratish', 2, 'male', 'yes', NULL),
(1, '1669050', 'Ratish', 22, 'male', 'yes', '20002000'),
(1, '1837254', 'RITESH', 22, 'male', 'yes', NULL),
(1, '2301850', 'RITESH', 22, 'male', 'yes', NULL),
(1, '2369143', 'Raaz', 22, 'male', 'yes', NULL),
(1, '3624147', 'rahul', 22, 'male', 'yes', NULL),
(1, '3688453', 'RITESH', 22, 'male', 'yes', '1234'),
(1, '5092485', 'ratish', 22, 'male', 'yes', NULL),
(1, '6308372', 'RITESH', 22, 'male', 'yes', '2000'),
(1, '7992746', 'ritesh', 22, 'male', 'yes', NULL),
(1, '8157678', 'RITESH', 22, 'male', 'yes', NULL),
(1, '8664151', 'RITESH', 22, 'male', 'yes', '2000'),
(1, '8846337', 'rahul', 23, 'male', 'yes', NULL),
(1, '9485525', 'RITESH', 22, 'male', 'yes', NULL),
(1, '9778262', 'RAHUL', 22, 'male', 'yes', NULL),
(2, '8157678', 'SANJU', 25, 'male', 'yes', NULL),
(2, '9485525', 'RITESH', 23, 'male', 'yes', NULL),
(4, '2369143', 'Rahul', 42, 'female', 'yes', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payment_details`
--

CREATE TABLE `payment_details` (
  `payment_id` varchar(20) NOT NULL,
  `pnr` varchar(15) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `payment_amount` int(6) DEFAULT NULL,
  `payment_mode` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `payment_details`
--

INSERT INTO `payment_details` (`payment_id`, `pnr`, `payment_date`, `payment_amount`, `payment_mode`) VALUES
('120000248', '4797983', '2017-11-25', 4200, 'credit card'),
('142539461', '3773951', '2017-11-25', 4050, 'credit card'),
('165125569', '8503285', '2017-11-25', 7500, 'net banking'),
('467972527', '2369143', '2017-11-26', 33400, 'debit card'),
('557778944', '6980157', '2017-11-26', 11700, 'credit card'),
('620041544', '1669050', '2017-11-25', 4800, 'debit card'),
('665360715', '5421865', '2017-11-28', 15750, 'net banking'),
('862686553', '3027167', '2017-11-25', 10700, 'debit card');

--
-- Triggers `payment_details`
--
DELIMITER $$
CREATE TRIGGER `update_ticket_after_payment` AFTER INSERT ON `payment_details` FOR EACH ROW UPDATE ticket_details
     SET booking_status='CONFIRMED', payment_id= NEW.payment_id
   WHERE pnr = NEW.pnr
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ticket_details`
--

CREATE TABLE `ticket_details` (
  `pnr` varchar(15) NOT NULL,
  `date_of_reservation` date DEFAULT NULL,
  `flight_no` varchar(10) DEFAULT NULL,
  `journey_date` date DEFAULT NULL,
  `class` varchar(10) DEFAULT NULL,
  `booking_status` varchar(20) DEFAULT NULL,
  `no_of_passengers` int(5) DEFAULT NULL,
  `lounge_access` varchar(5) DEFAULT NULL,
  `priority_checkin` varchar(5) DEFAULT NULL,
  `insurance` varchar(5) DEFAULT NULL,
  `payment_id` varchar(20) DEFAULT NULL,
  `customer_id` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `ticket_details`
--

INSERT INTO `ticket_details` (`pnr`, `date_of_reservation`, `flight_no`, `journey_date`, `class`, `booking_status`, `no_of_passengers`, `lounge_access`, `priority_checkin`, `insurance`, `payment_id`, `customer_id`) VALUES
('1379710', '2023-06-03', NULL, '2023-06-03', 'economy', 'PENDING', 1, 'yes', 'yes', 'yes', NULL, NULL),
('1669050', '2017-11-25', 'AA104', '2017-12-04', 'business', 'CONFIRMED', 3, 'yes', 'yes', 'yes', '620041544', 'mandal'),
('1837254', '2023-06-03', NULL, '2023-06-03', 'economy', 'PENDING', 1, 'yes', 'yes', 'yes', NULL, '12345'),
('2301850', '2023-06-03', NULL, '2023-06-03', 'economy', 'PENDING', 1, 'yes', 'yes', 'yes', NULL, '12345'),
('2369143', '2017-11-26', 'AA101', '2017-12-01', 'business', 'CONFIRMED', 4, 'yes', 'yes', 'yes', '467972527', 'rahul'),
('3624147', '2023-06-03', NULL, '2023-06-03', 'economy', 'PENDING', 1, 'yes', 'yes', 'yes', NULL, '12345'),
('3688453', '2023-06-09', NULL, '2023-06-09', 'economy', 'PENDING', 1, 'yes', 'yes', 'yes', NULL, '12345'),
('5092485', '2023-06-03', NULL, '2023-06-03', 'business', 'PENDING', 1, 'yes', 'yes', 'yes', NULL, '12345'),
('6308372', '2023-06-09', NULL, '2023-06-09', 'economy', 'PENDING', 1, 'yes', 'yes', 'yes', NULL, '12345'),
('7992746', '2023-06-03', NULL, '2023-06-03', 'economy', 'PENDING', 1, 'yes', 'yes', 'yes', NULL, '12345'),
('8157678', '2023-06-09', NULL, '2023-06-09', 'business', 'PENDING', 2, 'yes', 'yes', 'yes', NULL, '12345'),
('8664151', '2023-06-03', NULL, '2023-06-03', 'economy', 'PENDING', 1, 'yes', 'yes', 'yes', NULL, '12345'),
('8846337', '2023-06-03', NULL, '2023-06-03', 'economy', 'PENDING', 1, 'yes', 'yes', 'yes', NULL, '12345'),
('9485525', '2023-06-09', NULL, '2023-06-09', 'business', 'PENDING', 2, 'no', 'no', 'no', NULL, '12345'),
('9778262', '2023-06-03', NULL, '2023-06-03', 'business', 'PENDING', 1, 'yes', 'yes', 'yes', NULL, '12345');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `flight_details`
--
ALTER TABLE `flight_details`
  ADD PRIMARY KEY (`flight_no`,`departure_date`),
  ADD KEY `jet_id` (`jet_id`);

--
-- Indexes for table `frequent_flier_details`
--
ALTER TABLE `frequent_flier_details`
  ADD PRIMARY KEY (`frequent_flier_no`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `jet_details`
--
ALTER TABLE `jet_details`
  ADD PRIMARY KEY (`jet_id`);

--
-- Indexes for table `passengers`
--
ALTER TABLE `passengers`
  ADD PRIMARY KEY (`passenger_id`,`pnr`),
  ADD KEY `pnr` (`pnr`),
  ADD KEY `frequent_flier_no` (`frequent_flier_no`);

--
-- Indexes for table `payment_details`
--
ALTER TABLE `payment_details`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `pnr` (`pnr`);

--
-- Indexes for table `ticket_details`
--
ALTER TABLE `ticket_details`
  ADD PRIMARY KEY (`pnr`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `journey_date` (`journey_date`),
  ADD KEY `flight_no` (`flight_no`),
  ADD KEY `flight_no_2` (`flight_no`,`journey_date`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `flight_details`
--
ALTER TABLE `flight_details`
  ADD CONSTRAINT `flight_details_ibfk_1` FOREIGN KEY (`jet_id`) REFERENCES `jet_details` (`jet_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
