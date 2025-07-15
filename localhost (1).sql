-- phpMyAdmin SQL Dump
-- version 4.9.10
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 15, 2025 at 10:33 AM
-- Server version: 10.3.34-MariaDB-cll-lve
-- PHP Version: 5.5.38

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `chili_kegv1`
--
CREATE DATABASE IF NOT EXISTS `chili_kegv1` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `chili_kegv1`;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_actionscheduler_actions`
--

CREATE TABLE `fngs_actionscheduler_actions` (
  `action_id` bigint(20) UNSIGNED NOT NULL,
  `hook` varchar(191) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `scheduled_date_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  `scheduled_date_local` datetime DEFAULT '0000-00-00 00:00:00',
  `args` varchar(191) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `schedule` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `group_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `attempts` int(11) NOT NULL DEFAULT 0,
  `last_attempt_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  `last_attempt_local` datetime DEFAULT '0000-00-00 00:00:00',
  `claim_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `extended_args` varchar(8000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `priority` tinyint(3) UNSIGNED NOT NULL DEFAULT 10
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_actionscheduler_claims`
--

CREATE TABLE `fngs_actionscheduler_claims` (
  `claim_id` bigint(20) UNSIGNED NOT NULL,
  `date_created_gmt` datetime DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_actionscheduler_groups`
--

CREATE TABLE `fngs_actionscheduler_groups` (
  `group_id` bigint(20) UNSIGNED NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_actionscheduler_logs`
--

CREATE TABLE `fngs_actionscheduler_logs` (
  `log_id` bigint(20) UNSIGNED NOT NULL,
  `action_id` bigint(20) UNSIGNED NOT NULL,
  `message` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `log_date_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  `log_date_local` datetime DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_affiliate_wp_affiliatemeta`
--

CREATE TABLE `fngs_affiliate_wp_affiliatemeta` (
  `meta_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL DEFAULT 0,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_affiliate_wp_affiliates`
--

CREATE TABLE `fngs_affiliate_wp_affiliates` (
  `affiliate_id` bigint(20) NOT NULL,
  `rest_id` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `rate` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate_type` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `flat_rate_basis` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_email` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `earnings` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `unpaid_earnings` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `referrals` bigint(20) NOT NULL,
  `visits` bigint(20) NOT NULL,
  `date_registered` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_affiliate_wp_campaigns`
--

CREATE TABLE `fngs_affiliate_wp_campaigns` (
  `campaign_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL,
  `campaign` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `visits` bigint(20) NOT NULL,
  `unique_visits` bigint(20) NOT NULL,
  `referrals` bigint(20) NOT NULL,
  `conversion_rate` float NOT NULL,
  `hash` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rest_id` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_affiliate_wp_connections`
--

CREATE TABLE `fngs_affiliate_wp_connections` (
  `connection_id` bigint(20) NOT NULL,
  `date` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `group` bigint(20) DEFAULT NULL,
  `creative` bigint(20) DEFAULT NULL,
  `affiliate` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_affiliate_wp_coupons`
--

CREATE TABLE `fngs_affiliate_wp_coupons` (
  `coupon_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL,
  `coupon_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `locked` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_affiliate_wp_creativemeta`
--

CREATE TABLE `fngs_affiliate_wp_creativemeta` (
  `meta_id` bigint(20) NOT NULL,
  `creative_id` bigint(20) NOT NULL DEFAULT 0,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_affiliate_wp_creatives`
--

CREATE TABLE `fngs_affiliate_wp_creatives` (
  `creative_id` bigint(20) NOT NULL,
  `name` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `text` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachment_id` bigint(20) NOT NULL,
  `status` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  `date_updated` datetime NOT NULL DEFAULT current_timestamp(),
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `notes` longtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_affiliate_wp_customermeta`
--

CREATE TABLE `fngs_affiliate_wp_customermeta` (
  `meta_id` bigint(20) NOT NULL,
  `affwp_customer_id` bigint(20) NOT NULL DEFAULT 0,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_affiliate_wp_customers`
--

CREATE TABLE `fngs_affiliate_wp_customers` (
  `customer_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_affiliate_wp_custom_links`
--

CREATE TABLE `fngs_affiliate_wp_custom_links` (
  `custom_link_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL,
  `link` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `campaign` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_affiliate_wp_groups`
--

CREATE TABLE `fngs_affiliate_wp_groups` (
  `group_id` bigint(20) NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta` longtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_affiliate_wp_lifetime_customers`
--

CREATE TABLE `fngs_affiliate_wp_lifetime_customers` (
  `lifetime_customer_id` bigint(20) NOT NULL,
  `affwp_customer_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_affiliate_wp_notifications`
--

CREATE TABLE `fngs_affiliate_wp_notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `remote_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `buttons` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `type` varchar(64) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `conditions` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `dismissed` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_affiliate_wp_payouts`
--

CREATE TABLE `fngs_affiliate_wp_payouts` (
  `payout_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL,
  `referrals` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` bigint(20) NOT NULL,
  `payout_method` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_account` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_id` bigint(20) NOT NULL,
  `service_invoice_link` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_affiliate_wp_referralmeta`
--

CREATE TABLE `fngs_affiliate_wp_referralmeta` (
  `meta_id` bigint(20) NOT NULL,
  `referral_id` bigint(20) NOT NULL DEFAULT 0,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_affiliate_wp_referrals`
--

CREATE TABLE `fngs_affiliate_wp_referrals` (
  `referral_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL,
  `visit_id` bigint(20) NOT NULL,
  `rest_id` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `parent_id` bigint(20) NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency` char(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `custom` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `context` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `campaign` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `flag` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `products` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `payout_id` bigint(20) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_affiliate_wp_rest_consumers`
--

CREATE TABLE `fngs_affiliate_wp_rest_consumers` (
  `consumer_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `token` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `public_key` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret_key` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_affiliate_wp_sales`
--

CREATE TABLE `fngs_affiliate_wp_sales` (
  `referral_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL,
  `order_total` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_affiliate_wp_visits`
--

CREATE TABLE `fngs_affiliate_wp_visits` (
  `visit_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL,
  `referral_id` bigint(20) NOT NULL,
  `rest_id` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `referrer` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `campaign` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `context` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `flag` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_aioseo_cache`
--

CREATE TABLE `fngs_aioseo_cache` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(80) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `expiration` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_aioseo_notifications`
--

CREATE TABLE `fngs_aioseo_notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `slug` varchar(13) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `addon` varchar(64) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `type` varchar(64) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `level` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `notification_id` bigint(20) UNSIGNED DEFAULT NULL,
  `notification_name` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `button1_label` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `button1_action` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `button2_label` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `button2_action` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `dismissed` tinyint(1) NOT NULL DEFAULT 0,
  `new` tinyint(1) NOT NULL DEFAULT 1,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_aioseo_posts`
--

CREATE TABLE `fngs_aioseo_posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `keywords` mediumtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `keyphrases` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `page_analysis` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `canonical_url` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_description` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_object_type` varchar(64) COLLATE utf8mb4_unicode_520_ci DEFAULT 'default',
  `og_image_type` varchar(64) COLLATE utf8mb4_unicode_520_ci DEFAULT 'default',
  `og_image_url` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_image_width` int(11) DEFAULT NULL,
  `og_image_height` int(11) DEFAULT NULL,
  `og_image_custom_url` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_image_custom_fields` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_video` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_custom_url` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_article_section` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_article_tags` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_use_og` tinyint(1) DEFAULT 0,
  `twitter_card` varchar(64) COLLATE utf8mb4_unicode_520_ci DEFAULT 'default',
  `twitter_image_type` varchar(64) COLLATE utf8mb4_unicode_520_ci DEFAULT 'default',
  `twitter_image_url` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_image_custom_url` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_image_custom_fields` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_description` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `seo_score` int(11) NOT NULL DEFAULT 0,
  `schema` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `schema_type` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT 'default',
  `schema_type_options` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `pillar_content` tinyint(1) DEFAULT NULL,
  `robots_default` tinyint(1) NOT NULL DEFAULT 1,
  `robots_noindex` tinyint(1) NOT NULL DEFAULT 0,
  `robots_noarchive` tinyint(1) NOT NULL DEFAULT 0,
  `robots_nosnippet` tinyint(1) NOT NULL DEFAULT 0,
  `robots_nofollow` tinyint(1) NOT NULL DEFAULT 0,
  `robots_noimageindex` tinyint(1) NOT NULL DEFAULT 0,
  `robots_noodp` tinyint(1) NOT NULL DEFAULT 0,
  `robots_notranslate` tinyint(1) NOT NULL DEFAULT 0,
  `robots_max_snippet` int(11) DEFAULT NULL,
  `robots_max_videopreview` int(11) DEFAULT NULL,
  `robots_max_imagepreview` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT 'large',
  `images` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `image_scan_date` datetime DEFAULT NULL,
  `priority` tinytext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `frequency` tinytext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `videos` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `video_thumbnail` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `video_scan_date` datetime DEFAULT NULL,
  `local_seo` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `limit_modified_date` tinyint(1) NOT NULL DEFAULT 0,
  `options` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bb_background_job_queue`
--

CREATE TABLE `fngs_bb_background_job_queue` (
  `id` bigint(20) NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `group` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `data_id` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `secondary_data_id` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `data` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `priority` tinyint(2) DEFAULT NULL,
  `blog_id` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bb_background_process_logs`
--

CREATE TABLE `fngs_bb_background_process_logs` (
  `id` bigint(20) NOT NULL,
  `process_id` bigint(20) NOT NULL,
  `parent` bigint(20) DEFAULT NULL,
  `component` varchar(55) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `bg_process_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `bg_process_from` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `callback_function` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `blog_id` bigint(20) NOT NULL,
  `data` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `priority` bigint(10) DEFAULT NULL,
  `memory` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT '0',
  `process_start_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `process_start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `process_end_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `process_end_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bb_email_queue`
--

CREATE TABLE `fngs_bb_email_queue` (
  `id` bigint(20) NOT NULL,
  `email_type` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `recipient` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `arguments` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `scheduled` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bb_notifications_subscriptions`
--

CREATE TABLE `fngs_bb_notifications_subscriptions` (
  `id` bigint(20) NOT NULL,
  `blog_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `secondary_item_id` bigint(20) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `date_recorded` datetime DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bb_polls`
--

CREATE TABLE `fngs_bb_polls` (
  `id` bigint(20) NOT NULL,
  `item_id` bigint(20) DEFAULT 0,
  `item_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `secondary_item_id` bigint(20) DEFAULT 0,
  `user_id` bigint(20) NOT NULL,
  `question` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `settings` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `date_recorded` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `vote_disabled_date` datetime DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'draft'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bb_poll_options`
--

CREATE TABLE `fngs_bb_poll_options` (
  `id` bigint(20) NOT NULL,
  `poll_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `option_title` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `option_order` bigint(2) DEFAULT NULL,
  `date_recorded` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bb_poll_votes`
--

CREATE TABLE `fngs_bb_poll_votes` (
  `id` bigint(20) NOT NULL,
  `poll_id` bigint(20) NOT NULL,
  `option_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `date_recorded` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bb_reactions_data`
--

CREATE TABLE `fngs_bb_reactions_data` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `rel1` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `rel2` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `rel3` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bb_social_sign_on_users`
--

CREATE TABLE `fngs_bb_social_sign_on_users` (
  `id` int(11) NOT NULL,
  `wp_user_id` int(11) NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `identifier` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `register_date` datetime DEFAULT NULL,
  `login_date` datetime DEFAULT NULL,
  `link_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bb_user_reactions`
--

CREATE TABLE `fngs_bb_user_reactions` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `reaction_id` bigint(20) NOT NULL,
  `item_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bb_xprofile_visibility`
--

CREATE TABLE `fngs_bb_xprofile_visibility` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `field_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `value` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `last_updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_activity`
--

CREATE TABLE `fngs_bp_activity` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `component` varchar(75) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `type` varchar(75) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `action` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `primary_link` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `secondary_item_id` bigint(20) DEFAULT NULL,
  `date_recorded` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `hide_sitewide` tinyint(1) DEFAULT 0,
  `mptt_left` int(11) NOT NULL DEFAULT 0,
  `mptt_right` int(11) NOT NULL DEFAULT 0,
  `is_spam` tinyint(1) NOT NULL DEFAULT 0,
  `privacy` varchar(75) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'public',
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'published'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_activity_meta`
--

CREATE TABLE `fngs_bp_activity_meta` (
  `id` bigint(20) NOT NULL,
  `activity_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_document`
--

CREATE TABLE `fngs_bp_document` (
  `id` bigint(20) NOT NULL,
  `blog_id` bigint(20) DEFAULT NULL,
  `attachment_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `folder_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `activity_id` bigint(20) DEFAULT NULL,
  `message_id` bigint(20) DEFAULT 0,
  `privacy` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT 'public',
  `menu_order` bigint(20) DEFAULT 0,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'published',
  `date_created` datetime DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_document_folder`
--

CREATE TABLE `fngs_bp_document_folder` (
  `id` bigint(20) NOT NULL,
  `blog_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `parent` bigint(20) DEFAULT 0,
  `title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `privacy` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT 'public',
  `date_created` datetime DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_document_folder_meta`
--

CREATE TABLE `fngs_bp_document_folder_meta` (
  `id` bigint(20) NOT NULL,
  `folder_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_document_meta`
--

CREATE TABLE `fngs_bp_document_meta` (
  `id` bigint(20) NOT NULL,
  `document_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_follow`
--

CREATE TABLE `fngs_bp_follow` (
  `id` bigint(20) NOT NULL,
  `leader_id` bigint(20) NOT NULL,
  `follower_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_friends`
--

CREATE TABLE `fngs_bp_friends` (
  `id` bigint(20) NOT NULL,
  `initiator_user_id` bigint(20) NOT NULL,
  `friend_user_id` bigint(20) NOT NULL,
  `is_confirmed` tinyint(1) DEFAULT 0,
  `is_limited` tinyint(1) DEFAULT 0,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_groups`
--

CREATE TABLE `fngs_bp_groups` (
  `id` bigint(20) NOT NULL,
  `creator_id` bigint(20) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `slug` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `status` varchar(10) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'public',
  `parent_id` bigint(20) NOT NULL DEFAULT 0,
  `enable_forum` tinyint(1) NOT NULL DEFAULT 1,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_groups_groupmeta`
--

CREATE TABLE `fngs_bp_groups_groupmeta` (
  `id` bigint(20) NOT NULL,
  `group_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_groups_membermeta`
--

CREATE TABLE `fngs_bp_groups_membermeta` (
  `id` bigint(20) NOT NULL,
  `member_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_groups_members`
--

CREATE TABLE `fngs_bp_groups_members` (
  `id` bigint(20) NOT NULL,
  `group_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `inviter_id` bigint(20) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `is_mod` tinyint(1) NOT NULL DEFAULT 0,
  `user_title` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_modified` datetime NOT NULL,
  `comments` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `is_confirmed` tinyint(1) NOT NULL DEFAULT 0,
  `is_banned` tinyint(1) NOT NULL DEFAULT 0,
  `invite_sent` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_invitations`
--

CREATE TABLE `fngs_bp_invitations` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `inviter_id` bigint(20) NOT NULL,
  `invitee_email` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `class` varchar(120) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `secondary_item_id` bigint(20) DEFAULT NULL,
  `type` varchar(12) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'invite',
  `content` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `date_modified` datetime NOT NULL,
  `invite_sent` tinyint(1) NOT NULL DEFAULT 0,
  `accepted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_invitations_invitemeta`
--

CREATE TABLE `fngs_bp_invitations_invitemeta` (
  `id` bigint(20) NOT NULL,
  `invite_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_media`
--

CREATE TABLE `fngs_bp_media` (
  `id` bigint(20) NOT NULL,
  `blog_id` bigint(20) DEFAULT NULL,
  `attachment_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `album_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `activity_id` bigint(20) DEFAULT NULL,
  `message_id` bigint(20) DEFAULT 0,
  `privacy` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT 'public',
  `type` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT 'photo',
  `menu_order` bigint(20) DEFAULT 0,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'published',
  `date_created` datetime DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_media_albums`
--

CREATE TABLE `fngs_bp_media_albums` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT '0000-00-00 00:00:00',
  `title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `privacy` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT 'public'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_messages_messages`
--

CREATE TABLE `fngs_bp_messages_messages` (
  `id` bigint(20) NOT NULL,
  `thread_id` bigint(20) NOT NULL,
  `sender_id` bigint(20) NOT NULL,
  `subject` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_sent` datetime NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_messages_meta`
--

CREATE TABLE `fngs_bp_messages_meta` (
  `id` bigint(20) NOT NULL,
  `message_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_messages_notices`
--

CREATE TABLE `fngs_bp_messages_notices` (
  `id` bigint(20) NOT NULL,
  `subject` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_sent` datetime NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_messages_recipients`
--

CREATE TABLE `fngs_bp_messages_recipients` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `thread_id` bigint(20) NOT NULL,
  `unread_count` int(10) NOT NULL DEFAULT 0,
  `sender_only` tinyint(1) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  `is_hidden` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_moderation`
--

CREATE TABLE `fngs_bp_moderation` (
  `id` bigint(20) NOT NULL,
  `moderation_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_created` datetime DEFAULT '0000-00-00 00:00:00',
  `category_id` bigint(20) NOT NULL,
  `user_report` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_moderation_meta`
--

CREATE TABLE `fngs_bp_moderation_meta` (
  `id` bigint(20) NOT NULL,
  `moderation_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_notifications`
--

CREATE TABLE `fngs_bp_notifications` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `secondary_item_id` bigint(20) DEFAULT NULL,
  `component_name` varchar(75) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `component_action` varchar(75) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_notified` datetime NOT NULL,
  `is_new` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_notifications_meta`
--

CREATE TABLE `fngs_bp_notifications_meta` (
  `id` bigint(20) NOT NULL,
  `notification_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_optouts`
--

CREATE TABLE `fngs_bp_optouts` (
  `id` bigint(20) NOT NULL,
  `email_address_hash` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `email_type` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_suspend`
--

CREATE TABLE `fngs_bp_suspend` (
  `id` bigint(20) NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `item_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `hide_sitewide` tinyint(1) NOT NULL,
  `hide_parent` tinyint(1) NOT NULL,
  `user_suspended` tinyint(1) NOT NULL,
  `reported` tinyint(1) NOT NULL,
  `user_report` tinyint(4) DEFAULT 0,
  `last_updated` datetime DEFAULT '0000-00-00 00:00:00',
  `blog_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_suspend_details`
--

CREATE TABLE `fngs_bp_suspend_details` (
  `id` bigint(20) NOT NULL,
  `suspend_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_suspend_meta`
--

CREATE TABLE `fngs_bp_suspend_meta` (
  `id` bigint(20) NOT NULL,
  `suspend_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_xprofile_data`
--

CREATE TABLE `fngs_bp_xprofile_data` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `field_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `last_updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_xprofile_fields`
--

CREATE TABLE `fngs_bp_xprofile_fields` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `group_id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT 0,
  `is_default_option` tinyint(1) NOT NULL DEFAULT 0,
  `field_order` bigint(20) NOT NULL DEFAULT 0,
  `option_order` bigint(20) NOT NULL DEFAULT 0,
  `order_by` varchar(15) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `can_delete` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_xprofile_groups`
--

CREATE TABLE `fngs_bp_xprofile_groups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `group_order` bigint(20) NOT NULL DEFAULT 0,
  `can_delete` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_xprofile_meta`
--

CREATE TABLE `fngs_bp_xprofile_meta` (
  `id` bigint(20) NOT NULL,
  `object_id` bigint(20) NOT NULL,
  `object_type` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_zoom_meetings`
--

CREATE TABLE `fngs_bp_zoom_meetings` (
  `id` bigint(20) NOT NULL,
  `group_id` bigint(20) NOT NULL,
  `activity_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `host_id` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `type` int(10) NOT NULL DEFAULT 2,
  `title` varchar(300) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` varchar(800) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `start_date_utc` datetime NOT NULL,
  `timezone` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `password` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `duration` int(11) NOT NULL,
  `join_before_host` tinyint(1) DEFAULT 0,
  `host_video` tinyint(1) DEFAULT 0,
  `participants_video` tinyint(1) DEFAULT 0,
  `mute_participants` tinyint(1) DEFAULT 0,
  `waiting_room` tinyint(1) DEFAULT 0,
  `meeting_authentication` tinyint(1) DEFAULT 0,
  `recurring` tinyint(1) DEFAULT 0,
  `auto_recording` varchar(75) COLLATE utf8mb4_unicode_520_ci DEFAULT 'none',
  `alternative_host_ids` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meeting_id` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `hide_sitewide` tinyint(1) DEFAULT 0,
  `parent` varchar(150) COLLATE utf8mb4_unicode_520_ci DEFAULT '0',
  `zoom_type` varchar(150) COLLATE utf8mb4_unicode_520_ci DEFAULT 'meeting',
  `alert` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_zoom_meeting_meta`
--

CREATE TABLE `fngs_bp_zoom_meeting_meta` (
  `id` bigint(20) NOT NULL,
  `meeting_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_zoom_recordings`
--

CREATE TABLE `fngs_bp_zoom_recordings` (
  `id` bigint(20) NOT NULL,
  `recording_id` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `meeting_id` bigint(20) NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `details` varchar(800) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `file_type` varchar(800) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `password` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `start_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_zoom_webinars`
--

CREATE TABLE `fngs_bp_zoom_webinars` (
  `id` bigint(20) NOT NULL,
  `group_id` bigint(20) NOT NULL,
  `activity_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `host_id` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `type` int(10) NOT NULL DEFAULT 2,
  `title` varchar(300) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` varchar(800) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `start_date_utc` datetime NOT NULL,
  `timezone` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `password` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `duration` int(11) NOT NULL,
  `host_video` tinyint(1) DEFAULT 0,
  `panelists_video` tinyint(1) DEFAULT 0,
  `meeting_authentication` tinyint(1) DEFAULT 0,
  `practice_session` tinyint(1) DEFAULT 0,
  `on_demand` tinyint(1) DEFAULT 0,
  `recurring` tinyint(1) DEFAULT 0,
  `auto_recording` varchar(75) COLLATE utf8mb4_unicode_520_ci DEFAULT 'none',
  `alternative_host_ids` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `webinar_id` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `hide_sitewide` tinyint(1) DEFAULT 0,
  `parent` varchar(150) COLLATE utf8mb4_unicode_520_ci DEFAULT '0',
  `zoom_type` varchar(150) COLLATE utf8mb4_unicode_520_ci DEFAULT 'webinar',
  `alert` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_zoom_webinar_meta`
--

CREATE TABLE `fngs_bp_zoom_webinar_meta` (
  `id` bigint(20) NOT NULL,
  `webinar_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_bp_zoom_webinar_recordings`
--

CREATE TABLE `fngs_bp_zoom_webinar_recordings` (
  `id` bigint(20) NOT NULL,
  `recording_id` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `webinar_id` bigint(20) NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `details` varchar(800) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `file_type` varchar(800) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `password` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `start_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_commentmeta`
--

CREATE TABLE `fngs_commentmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `comment_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_comments`
--

CREATE TABLE `fngs_comments` (
  `comment_ID` bigint(20) UNSIGNED NOT NULL,
  `comment_post_ID` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `comment_author` tinytext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_author_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_url` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_IP` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_karma` int(11) NOT NULL DEFAULT 0,
  `comment_approved` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '1',
  `comment_agent` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'comment',
  `comment_parent` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_e_events`
--

CREATE TABLE `fngs_e_events` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `event_data` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_e_notes`
--

CREATE TABLE `fngs_e_notes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `route_url` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'Clean url where the note was created.',
  `route_title` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `route_post_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'The post id of the route that the note was created on.',
  `post_id` bigint(20) UNSIGNED DEFAULT NULL,
  `element_id` varchar(60) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'The Elementor element ID the note is attached to.',
  `parent_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `author_id` bigint(20) UNSIGNED DEFAULT NULL,
  `author_display_name` varchar(250) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'Save the author name when the author was deleted.',
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'publish',
  `position` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'A JSON string that represents the position of the note inside the element in percentages. e.g. {x:10, y:15}',
  `content` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `is_resolved` tinyint(1) NOT NULL DEFAULT 0,
  `is_public` tinyint(1) NOT NULL DEFAULT 1,
  `last_activity_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_e_notes_users_relations`
--

CREATE TABLE `fngs_e_notes_users_relations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL COMMENT 'The relation type between user and note (e.g mention, watch, read).',
  `note_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_e_submissions`
--

CREATE TABLE `fngs_e_submissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(60) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `hash_id` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `main_meta_id` bigint(20) UNSIGNED NOT NULL COMMENT 'Id of main field. to represent the main meta field',
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `referer` varchar(500) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `referer_title` varchar(300) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `element_id` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `form_name` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `campaign_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_ip` varchar(46) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `actions_count` int(11) DEFAULT 0,
  `actions_succeeded_count` int(11) DEFAULT 0,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `meta` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `created_at_gmt` datetime NOT NULL,
  `updated_at_gmt` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_e_submissions_actions_log`
--

CREATE TABLE `fngs_e_submissions_actions_log` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `submission_id` bigint(20) UNSIGNED NOT NULL,
  `action_name` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `action_label` varchar(60) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `log` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `created_at_gmt` datetime NOT NULL,
  `updated_at_gmt` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_e_submissions_values`
--

CREATE TABLE `fngs_e_submissions_values` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `submission_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `key` varchar(60) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_facetwp_index`
--

CREATE TABLE `fngs_facetwp_index` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` int(10) UNSIGNED DEFAULT NULL,
  `facet_name` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `facet_value` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `facet_display_value` varchar(200) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `term_id` int(10) UNSIGNED DEFAULT 0,
  `parent_id` int(10) UNSIGNED DEFAULT 0,
  `depth` int(10) UNSIGNED DEFAULT 0,
  `variation_id` int(10) UNSIGNED DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_gf_addon_feed`
--

CREATE TABLE `fngs_gf_addon_feed` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `form_id` mediumint(8) UNSIGNED NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `feed_order` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `meta` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `addon_slug` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `event_type` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_gf_addon_payment_transaction`
--

CREATE TABLE `fngs_gf_addon_payment_transaction` (
  `id` int(10) UNSIGNED NOT NULL,
  `lead_id` int(10) UNSIGNED NOT NULL,
  `transaction_type` varchar(30) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `transaction_id` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `subscription_id` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `is_recurring` tinyint(1) NOT NULL DEFAULT 0,
  `amount` decimal(19,2) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_gf_draft_submissions`
--

CREATE TABLE `fngs_gf_draft_submissions` (
  `uuid` char(32) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `form_id` mediumint(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `ip` varchar(45) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `source_url` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `submission` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_gf_entry`
--

CREATE TABLE `fngs_gf_entry` (
  `id` int(10) UNSIGNED NOT NULL,
  `form_id` mediumint(10) UNSIGNED NOT NULL,
  `post_id` bigint(10) UNSIGNED DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime DEFAULT NULL,
  `is_starred` tinyint(10) NOT NULL DEFAULT 0,
  `is_read` tinyint(10) NOT NULL DEFAULT 0,
  `ip` varchar(45) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `source_url` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_agent` varchar(250) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `currency` varchar(5) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `payment_status` varchar(15) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `payment_amount` decimal(19,2) DEFAULT NULL,
  `payment_method` varchar(30) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `transaction_id` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `is_fulfilled` tinyint(10) DEFAULT NULL,
  `created_by` bigint(10) UNSIGNED DEFAULT NULL,
  `transaction_type` tinyint(10) DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'active',
  `source_id` bigint(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_gf_entry_meta`
--

CREATE TABLE `fngs_gf_entry_meta` (
  `id` bigint(10) UNSIGNED NOT NULL,
  `form_id` mediumint(10) UNSIGNED NOT NULL DEFAULT 0,
  `entry_id` bigint(10) UNSIGNED NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `item_index` varchar(60) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_gf_entry_notes`
--

CREATE TABLE `fngs_gf_entry_notes` (
  `id` int(10) UNSIGNED NOT NULL,
  `entry_id` int(10) UNSIGNED NOT NULL,
  `user_name` varchar(250) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `user_id` bigint(10) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `note_type` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `sub_type` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_gf_form`
--

CREATE TABLE `fngs_gf_form` (
  `id` mediumint(10) UNSIGNED NOT NULL,
  `title` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime DEFAULT NULL,
  `is_active` tinyint(10) NOT NULL DEFAULT 1,
  `is_trash` tinyint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_gf_form_meta`
--

CREATE TABLE `fngs_gf_form_meta` (
  `form_id` mediumint(10) UNSIGNED NOT NULL,
  `display_meta` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `entries_grid_meta` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `confirmations` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `notifications` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_gf_form_revisions`
--

CREATE TABLE `fngs_gf_form_revisions` (
  `id` bigint(10) UNSIGNED NOT NULL,
  `form_id` mediumint(10) UNSIGNED NOT NULL,
  `display_meta` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_gf_form_view`
--

CREATE TABLE `fngs_gf_form_view` (
  `id` bigint(10) UNSIGNED NOT NULL,
  `form_id` mediumint(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `ip` char(15) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `count` mediumint(10) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_gf_rest_api_keys`
--

CREATE TABLE `fngs_gf_rest_api_keys` (
  `key_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `permissions` varchar(10) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `consumer_key` char(64) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `consumer_secret` char(43) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `nonces` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `truncated_key` char(7) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `last_access` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_links`
--

CREATE TABLE `fngs_links` (
  `link_id` bigint(20) UNSIGNED NOT NULL,
  `link_url` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_image` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_target` varchar(25) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_description` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_visible` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'Y',
  `link_owner` bigint(20) UNSIGNED NOT NULL DEFAULT 1,
  `link_rating` int(11) NOT NULL DEFAULT 0,
  `link_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_notes` mediumtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `link_rss` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_options`
--

CREATE TABLE `fngs_options` (
  `option_id` bigint(20) UNSIGNED NOT NULL,
  `option_name` varchar(191) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `option_value` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `autoload` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'yes'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_pmxi_files`
--

CREATE TABLE `fngs_pmxi_files` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `import_id` bigint(20) UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `path` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `registered_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_pmxi_geocoding`
--

CREATE TABLE `fngs_pmxi_geocoding` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `address` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `latitude` decimal(18,15) DEFAULT NULL,
  `longitude` decimal(18,15) DEFAULT NULL,
  `raw_data` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `provider` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'google_maps',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_pmxi_hash`
--

CREATE TABLE `fngs_pmxi_hash` (
  `hash` binary(16) NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `import_id` smallint(5) UNSIGNED NOT NULL,
  `post_type` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_pmxi_history`
--

CREATE TABLE `fngs_pmxi_history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `import_id` bigint(20) UNSIGNED NOT NULL,
  `type` enum('manual','processing','trigger','continue','cli','') COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `time_run` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `summary` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_pmxi_images`
--

CREATE TABLE `fngs_pmxi_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `attachment_id` bigint(20) UNSIGNED NOT NULL,
  `image_url` text COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `image_filename` text COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_pmxi_imports`
--

CREATE TABLE `fngs_pmxi_imports` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `parent_import_id` bigint(20) NOT NULL DEFAULT 0,
  `name` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `friendly_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `type` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `feed_type` enum('xml','csv','zip','gz','') COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `path` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `xpath` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `options` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `registered_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `root_element` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `processing` tinyint(1) NOT NULL DEFAULT 0,
  `executing` tinyint(1) NOT NULL DEFAULT 0,
  `triggered` tinyint(1) NOT NULL DEFAULT 0,
  `queue_chunk_number` bigint(20) NOT NULL DEFAULT 0,
  `first_import` timestamp NOT NULL DEFAULT current_timestamp(),
  `count` bigint(20) NOT NULL DEFAULT 0,
  `imported` bigint(20) NOT NULL DEFAULT 0,
  `created` bigint(20) NOT NULL DEFAULT 0,
  `updated` bigint(20) NOT NULL DEFAULT 0,
  `skipped` bigint(20) NOT NULL DEFAULT 0,
  `deleted` bigint(20) NOT NULL DEFAULT 0,
  `canceled` tinyint(1) NOT NULL DEFAULT 0,
  `canceled_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `failed` tinyint(1) NOT NULL DEFAULT 0,
  `failed_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `settings_update_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_activity` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `iteration` bigint(20) NOT NULL DEFAULT 0,
  `changed_missing` bigint(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_pmxi_posts`
--

CREATE TABLE `fngs_pmxi_posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `import_id` bigint(20) UNSIGNED NOT NULL,
  `unique_key` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `product_key` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `iteration` bigint(20) NOT NULL DEFAULT 0,
  `specified` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_pmxi_templates`
--

CREATE TABLE `fngs_pmxi_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `options` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `scheduled` varchar(64) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `is_keep_linebreaks` tinyint(1) NOT NULL DEFAULT 0,
  `is_leave_html` tinyint(1) NOT NULL DEFAULT 0,
  `fix_characters` tinyint(1) NOT NULL DEFAULT 0,
  `meta` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_postmeta`
--

CREATE TABLE `fngs_postmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_posts`
--

CREATE TABLE `fngs_posts` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `post_author` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_excerpt` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `post_password` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `post_name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `to_ping` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `pinged` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_parent` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `guid` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `menu_order` int(11) NOT NULL DEFAULT 0,
  `post_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_count` bigint(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_post_smtp_logmeta`
--

CREATE TABLE `fngs_post_smtp_logmeta` (
  `id` bigint(20) NOT NULL,
  `log_id` bigint(20) NOT NULL,
  `meta_key` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_post_smtp_logs`
--

CREATE TABLE `fngs_post_smtp_logs` (
  `id` bigint(20) NOT NULL,
  `solution` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `success` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `from_header` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `to_header` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `cc_header` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `bcc_header` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `reply_to_header` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `transport_uri` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `original_to` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `original_subject` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `original_message` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `original_headers` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `session_transcript` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `time` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_pronamic_pay_mollie_customers`
--

CREATE TABLE `fngs_pronamic_pay_mollie_customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `mollie_id` varchar(40) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `organization_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_id` bigint(20) UNSIGNED DEFAULT NULL,
  `test_mode` tinyint(1) NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_pronamic_pay_mollie_customer_users`
--

CREATE TABLE `fngs_pronamic_pay_mollie_customer_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_pronamic_pay_mollie_organizations`
--

CREATE TABLE `fngs_pronamic_pay_mollie_organizations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `mollie_id` varchar(40) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `name` varchar(128) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_pronamic_pay_mollie_profiles`
--

CREATE TABLE `fngs_pronamic_pay_mollie_profiles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `mollie_id` varchar(40) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `organization_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(128) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `api_key_test` varchar(35) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `api_key_live` varchar(35) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_rp4wp_cache`
--

CREATE TABLE `fngs_rp4wp_cache` (
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `word` varchar(255) NOT NULL,
  `weight` float UNSIGNED NOT NULL,
  `post_type` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_rtwapwcm_mlm`
--

CREATE TABLE `fngs_rtwapwcm_mlm` (
  `id` mediumint(9) NOT NULL,
  `aff_id` bigint(20) NOT NULL,
  `parent_id` bigint(20) NOT NULL,
  `level` int(11) NOT NULL DEFAULT 1,
  `level_active` int(11) NOT NULL DEFAULT 1,
  `level_comm` decimal(10,2) NOT NULL DEFAULT 0.00,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `last_activity` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `added_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_rtwapwcm_referrals`
--

CREATE TABLE `fngs_rtwapwcm_referrals` (
  `id` mediumint(9) NOT NULL,
  `aff_id` bigint(20) NOT NULL,
  `type` tinyint(1) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `batch_id` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` tinyint(2) NOT NULL DEFAULT 0,
  `amount` decimal(12,2) NOT NULL,
  `capped` tinyint(1) NOT NULL DEFAULT 0,
  `currency` varchar(55) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `product_details` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `payment_type` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `device` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `ip` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `signed_up_id` int(10) NOT NULL,
  `payment_create_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `payment_update_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `message` varchar(150) COLLATE utf8mb4_unicode_520_ci DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_rtwapwcm_referral_link`
--

CREATE TABLE `fngs_rtwapwcm_referral_link` (
  `id` mediumint(9) NOT NULL,
  `aff_id` bigint(20) NOT NULL,
  `aff_link` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `link_open` int(10) NOT NULL DEFAULT 0,
  `link_purchase` int(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_rtwapwcm_visitors_track`
--

CREATE TABLE `fngs_rtwapwcm_visitors_track` (
  `id` int(6) NOT NULL,
  `aff_id` int(6) NOT NULL,
  `ref_link` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `agent` varchar(30) COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `device` varchar(10) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `platform` varchar(25) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `ip` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `count` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_rtwapwcm_wallet_transaction`
--

CREATE TABLE `fngs_rtwapwcm_wallet_transaction` (
  `id` mediumint(9) NOT NULL,
  `aff_id` bigint(20) NOT NULL,
  `request_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `amount` decimal(12,2) NOT NULL,
  `pay_status` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `batch_id` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_signups`
--

CREATE TABLE `fngs_signups` (
  `signup_id` bigint(20) NOT NULL,
  `domain` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `path` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `title` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_login` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `activated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT 0,
  `activation_key` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `meta` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_termmeta`
--

CREATE TABLE `fngs_termmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_terms`
--

CREATE TABLE `fngs_terms` (
  `term_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `slug` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `term_group` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_term_relationships`
--

CREATE TABLE `fngs_term_relationships` (
  `object_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `term_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_term_taxonomy`
--

CREATE TABLE `fngs_term_taxonomy` (
  `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `taxonomy` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `description` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `parent` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `count` bigint(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_uap_action_log`
--

CREATE TABLE `fngs_uap_action_log` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `date_time` timestamp NULL DEFAULT current_timestamp(),
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `automator_action_id` bigint(20) UNSIGNED NOT NULL,
  `automator_recipe_id` bigint(20) UNSIGNED NOT NULL,
  `automator_recipe_log_id` bigint(20) UNSIGNED DEFAULT NULL,
  `completed` tinyint(1) UNSIGNED NOT NULL,
  `error_message` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_uap_action_log_meta`
--

CREATE TABLE `fngs_uap_action_log_meta` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `automator_action_log_id` bigint(20) UNSIGNED DEFAULT NULL,
  `automator_action_id` bigint(20) UNSIGNED NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_uap_api_log`
--

CREATE TABLE `fngs_uap_api_log` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `date_time` timestamp NULL DEFAULT current_timestamp(),
  `type` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `recipe_log_id` bigint(20) UNSIGNED NOT NULL,
  `item_log_id` bigint(20) UNSIGNED NOT NULL,
  `endpoint` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `params` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `request` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `response` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `price` bigint(20) UNSIGNED DEFAULT NULL,
  `balance` bigint(20) UNSIGNED DEFAULT NULL,
  `time_spent` bigint(20) UNSIGNED DEFAULT NULL,
  `notes` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_uap_closure_log`
--

CREATE TABLE `fngs_uap_closure_log` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `date_time` timestamp NULL DEFAULT current_timestamp(),
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `automator_closure_id` bigint(20) UNSIGNED NOT NULL,
  `automator_recipe_id` bigint(20) UNSIGNED NOT NULL,
  `automator_recipe_log_id` bigint(20) UNSIGNED NOT NULL,
  `completed` tinyint(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_uap_closure_log_meta`
--

CREATE TABLE `fngs_uap_closure_log_meta` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `automator_closure_id` bigint(20) UNSIGNED NOT NULL,
  `automator_closure_log_id` bigint(20) UNSIGNED NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_uap_recipe_log`
--

CREATE TABLE `fngs_uap_recipe_log` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `date_time` timestamp NULL DEFAULT current_timestamp(),
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `automator_recipe_id` bigint(20) UNSIGNED NOT NULL,
  `completed` tinyint(1) NOT NULL,
  `run_number` mediumint(8) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_uap_trigger_log`
--

CREATE TABLE `fngs_uap_trigger_log` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `date_time` timestamp NULL DEFAULT current_timestamp(),
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `automator_trigger_id` bigint(20) UNSIGNED NOT NULL,
  `automator_recipe_id` bigint(20) UNSIGNED NOT NULL,
  `automator_recipe_log_id` bigint(20) UNSIGNED DEFAULT NULL,
  `completed` tinyint(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_uap_trigger_log_meta`
--

CREATE TABLE `fngs_uap_trigger_log_meta` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `automator_trigger_log_id` bigint(20) UNSIGNED DEFAULT NULL,
  `automator_trigger_id` bigint(20) UNSIGNED NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `run_number` mediumint(8) UNSIGNED NOT NULL DEFAULT 1,
  `run_time` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_usermeta`
--

CREATE TABLE `fngs_usermeta` (
  `umeta_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_users`
--

CREATE TABLE `fngs_users` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `user_login` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_pass` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_nicename` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_url` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_status` int(11) NOT NULL DEFAULT 0,
  `display_name` varchar(250) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wc_admin_notes`
--

CREATE TABLE `fngs_wc_admin_notes` (
  `note_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `locale` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `title` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content_data` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `status` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `source` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_reminder` datetime DEFAULT NULL,
  `is_snoozable` tinyint(1) NOT NULL DEFAULT 0,
  `layout` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `image` varchar(200) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `icon` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'info'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wc_admin_note_actions`
--

CREATE TABLE `fngs_wc_admin_note_actions` (
  `action_id` bigint(20) UNSIGNED NOT NULL,
  `note_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `query` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `actioned_text` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `nonce_action` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `nonce_name` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wc_category_lookup`
--

CREATE TABLE `fngs_wc_category_lookup` (
  `category_tree_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wc_customer_lookup`
--

CREATE TABLE `fngs_wc_customer_lookup` (
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `username` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `first_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `date_last_active` timestamp NULL DEFAULT NULL,
  `date_registered` timestamp NULL DEFAULT NULL,
  `country` char(2) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `postcode` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `city` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `state` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wc_download_log`
--

CREATE TABLE `fngs_wc_download_log` (
  `download_log_id` bigint(20) UNSIGNED NOT NULL,
  `timestamp` datetime NOT NULL,
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_ip_address` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wc_orders`
--

CREATE TABLE `fngs_wc_orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `currency` varchar(10) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `tax_amount` decimal(26,8) DEFAULT NULL,
  `total_amount` decimal(26,8) DEFAULT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `billing_email` varchar(320) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `date_created_gmt` datetime DEFAULT NULL,
  `date_updated_gmt` datetime DEFAULT NULL,
  `parent_order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payment_method` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `payment_method_title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `transaction_id` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `ip_address` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `customer_note` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wc_orders_meta`
--

CREATE TABLE `fngs_wc_orders_meta` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wc_order_addresses`
--

CREATE TABLE `fngs_wc_order_addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `address_type` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `first_name` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `last_name` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `company` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `address_1` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `address_2` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `city` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `state` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `postcode` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `country` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `email` varchar(320) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `phone` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wc_order_coupon_lookup`
--

CREATE TABLE `fngs_wc_order_coupon_lookup` (
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `coupon_id` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `discount_amount` double NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wc_order_operational_data`
--

CREATE TABLE `fngs_wc_order_operational_data` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_via` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `woocommerce_version` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `prices_include_tax` tinyint(1) DEFAULT NULL,
  `coupon_usages_are_counted` tinyint(1) DEFAULT NULL,
  `download_permission_granted` tinyint(1) DEFAULT NULL,
  `cart_hash` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `new_order_email_sent` tinyint(1) DEFAULT NULL,
  `order_key` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `order_stock_reduced` tinyint(1) DEFAULT NULL,
  `date_paid_gmt` datetime DEFAULT NULL,
  `date_completed_gmt` datetime DEFAULT NULL,
  `shipping_tax_amount` decimal(26,8) DEFAULT NULL,
  `shipping_total_amount` decimal(26,8) DEFAULT NULL,
  `discount_tax_amount` decimal(26,8) DEFAULT NULL,
  `discount_total_amount` decimal(26,8) DEFAULT NULL,
  `recorded_sales` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wc_order_product_lookup`
--

CREATE TABLE `fngs_wc_order_product_lookup` (
  `order_item_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `variation_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `product_qty` int(11) NOT NULL,
  `product_net_revenue` double NOT NULL DEFAULT 0,
  `product_gross_revenue` double NOT NULL DEFAULT 0,
  `coupon_amount` double NOT NULL DEFAULT 0,
  `tax_amount` double NOT NULL DEFAULT 0,
  `shipping_amount` double NOT NULL DEFAULT 0,
  `shipping_tax_amount` double NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wc_order_stats`
--

CREATE TABLE `fngs_wc_order_stats` (
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_created_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_paid` datetime DEFAULT '0000-00-00 00:00:00',
  `date_completed` datetime DEFAULT '0000-00-00 00:00:00',
  `num_items_sold` int(11) NOT NULL DEFAULT 0,
  `total_sales` double NOT NULL DEFAULT 0,
  `tax_total` double NOT NULL DEFAULT 0,
  `shipping_total` double NOT NULL DEFAULT 0,
  `net_total` double NOT NULL DEFAULT 0,
  `returning_customer` tinyint(1) DEFAULT NULL,
  `status` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wc_order_tax_lookup`
--

CREATE TABLE `fngs_wc_order_tax_lookup` (
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `tax_rate_id` bigint(20) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `shipping_tax` double NOT NULL DEFAULT 0,
  `order_tax` double NOT NULL DEFAULT 0,
  `total_tax` double NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wc_product_attributes_lookup`
--

CREATE TABLE `fngs_wc_product_attributes_lookup` (
  `product_id` bigint(20) NOT NULL,
  `product_or_parent_id` bigint(20) NOT NULL,
  `taxonomy` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `term_id` bigint(20) NOT NULL,
  `is_variation_attribute` tinyint(1) NOT NULL,
  `in_stock` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wc_product_download_directories`
--

CREATE TABLE `fngs_wc_product_download_directories` (
  `url_id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(256) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wc_product_meta_lookup`
--

CREATE TABLE `fngs_wc_product_meta_lookup` (
  `product_id` bigint(20) NOT NULL,
  `sku` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `global_unique_id` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `virtual` tinyint(1) DEFAULT 0,
  `downloadable` tinyint(1) DEFAULT 0,
  `min_price` decimal(19,4) DEFAULT NULL,
  `max_price` decimal(19,4) DEFAULT NULL,
  `onsale` tinyint(1) DEFAULT 0,
  `stock_quantity` double DEFAULT NULL,
  `stock_status` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT 'instock',
  `rating_count` bigint(20) DEFAULT 0,
  `average_rating` decimal(3,2) DEFAULT 0.00,
  `total_sales` bigint(20) DEFAULT 0,
  `tax_status` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT 'taxable',
  `tax_class` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wc_rate_limits`
--

CREATE TABLE `fngs_wc_rate_limits` (
  `rate_limit_id` bigint(20) UNSIGNED NOT NULL,
  `rate_limit_key` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `rate_limit_expiry` bigint(20) UNSIGNED NOT NULL,
  `rate_limit_remaining` smallint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wc_reserved_stock`
--

CREATE TABLE `fngs_wc_reserved_stock` (
  `order_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `stock_quantity` double NOT NULL DEFAULT 0,
  `timestamp` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `expires` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wc_tax_rate_classes`
--

CREATE TABLE `fngs_wc_tax_rate_classes` (
  `tax_rate_class_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `slug` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wc_webhooks`
--

CREATE TABLE `fngs_wc_webhooks` (
  `webhook_id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `name` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `delivery_url` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `secret` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `topic` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_created_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `api_version` smallint(4) NOT NULL,
  `failure_count` smallint(10) NOT NULL DEFAULT 0,
  `pending_delivery` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_woocommerce_api_keys`
--

CREATE TABLE `fngs_woocommerce_api_keys` (
  `key_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `permissions` varchar(10) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `consumer_key` char(64) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `consumer_secret` char(43) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `nonces` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `truncated_key` char(7) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `last_access` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_woocommerce_attribute_taxonomies`
--

CREATE TABLE `fngs_woocommerce_attribute_taxonomies` (
  `attribute_id` bigint(20) UNSIGNED NOT NULL,
  `attribute_name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `attribute_label` varchar(200) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `attribute_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `attribute_orderby` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `attribute_public` int(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_woocommerce_downloadable_product_permissions`
--

CREATE TABLE `fngs_woocommerce_downloadable_product_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `download_id` varchar(36) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `order_key` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_email` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `downloads_remaining` varchar(9) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `access_granted` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `access_expires` datetime DEFAULT NULL,
  `download_count` bigint(20) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_woocommerce_log`
--

CREATE TABLE `fngs_woocommerce_log` (
  `log_id` bigint(20) UNSIGNED NOT NULL,
  `timestamp` datetime NOT NULL,
  `level` smallint(4) NOT NULL,
  `source` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `context` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_woocommerce_order_itemmeta`
--

CREATE TABLE `fngs_woocommerce_order_itemmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `order_item_id` bigint(20) UNSIGNED NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_woocommerce_order_items`
--

CREATE TABLE `fngs_woocommerce_order_items` (
  `order_item_id` bigint(20) UNSIGNED NOT NULL,
  `order_item_name` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `order_item_type` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `order_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_woocommerce_payment_tokenmeta`
--

CREATE TABLE `fngs_woocommerce_payment_tokenmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `payment_token_id` bigint(20) UNSIGNED NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_woocommerce_payment_tokens`
--

CREATE TABLE `fngs_woocommerce_payment_tokens` (
  `token_id` bigint(20) UNSIGNED NOT NULL,
  `gateway_id` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `token` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `type` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_woocommerce_sessions`
--

CREATE TABLE `fngs_woocommerce_sessions` (
  `session_id` bigint(20) UNSIGNED NOT NULL,
  `session_key` char(32) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `session_value` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `session_expiry` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_woocommerce_shipping_zones`
--

CREATE TABLE `fngs_woocommerce_shipping_zones` (
  `zone_id` bigint(20) UNSIGNED NOT NULL,
  `zone_name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `zone_order` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_woocommerce_shipping_zone_locations`
--

CREATE TABLE `fngs_woocommerce_shipping_zone_locations` (
  `location_id` bigint(20) UNSIGNED NOT NULL,
  `zone_id` bigint(20) UNSIGNED NOT NULL,
  `location_code` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `location_type` varchar(40) COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_woocommerce_shipping_zone_methods`
--

CREATE TABLE `fngs_woocommerce_shipping_zone_methods` (
  `zone_id` bigint(20) UNSIGNED NOT NULL,
  `instance_id` bigint(20) UNSIGNED NOT NULL,
  `method_id` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `method_order` bigint(20) UNSIGNED NOT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_woocommerce_tax_rates`
--

CREATE TABLE `fngs_woocommerce_tax_rates` (
  `tax_rate_id` bigint(20) UNSIGNED NOT NULL,
  `tax_rate_country` varchar(2) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `tax_rate_state` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `tax_rate` varchar(8) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `tax_rate_name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `tax_rate_priority` bigint(20) UNSIGNED NOT NULL,
  `tax_rate_compound` int(1) NOT NULL DEFAULT 0,
  `tax_rate_shipping` int(1) NOT NULL DEFAULT 1,
  `tax_rate_order` bigint(20) UNSIGNED NOT NULL,
  `tax_rate_class` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_woocommerce_tax_rate_locations`
--

CREATE TABLE `fngs_woocommerce_tax_rate_locations` (
  `location_id` bigint(20) UNSIGNED NOT NULL,
  `location_code` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `tax_rate_id` bigint(20) UNSIGNED NOT NULL,
  `location_type` varchar(40) COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wpmailsmtp_debug_events`
--

CREATE TABLE `fngs_wpmailsmtp_debug_events` (
  `id` int(10) UNSIGNED NOT NULL,
  `content` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `initiator` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `event_type` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wpmailsmtp_tasks_meta`
--

CREATE TABLE `fngs_wpmailsmtp_tasks_meta` (
  `id` bigint(20) NOT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `data` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wpr_above_the_fold`
--

CREATE TABLE `fngs_wpr_above_the_fold` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(2000) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `is_mobile` tinyint(1) NOT NULL DEFAULT 0,
  `lcp` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `viewport` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `error_message` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_accessed` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wpr_lazy_render_content`
--

CREATE TABLE `fngs_wpr_lazy_render_content` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(2000) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `is_mobile` tinyint(1) NOT NULL DEFAULT 0,
  `below_the_fold` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `error_message` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `status` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_accessed` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wpr_preconnect_external_domains`
--

CREATE TABLE `fngs_wpr_preconnect_external_domains` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(2000) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `is_mobile` tinyint(1) NOT NULL DEFAULT 0,
  `domains` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `error_message` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `status` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_accessed` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wpr_preload_fonts`
--

CREATE TABLE `fngs_wpr_preload_fonts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(2000) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `is_mobile` tinyint(1) NOT NULL DEFAULT 0,
  `fonts` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `error_message` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `status` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_accessed` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wpr_rocket_cache`
--

CREATE TABLE `fngs_wpr_rocket_cache` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(2000) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `status` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_accessed` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_locked` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wpr_rucss_used_css`
--

CREATE TABLE `fngs_wpr_rucss_used_css` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(2000) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `css` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `hash` varchar(32) COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `error_code` varchar(32) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `error_message` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `unprocessedcss` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `retries` tinyint(1) NOT NULL DEFAULT 1,
  `is_mobile` tinyint(1) NOT NULL DEFAULT 0,
  `job_id` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `queue_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `status` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_accessed` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `submitted_at` timestamp NULL DEFAULT NULL,
  `next_retry_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wsal_metadata`
--

CREATE TABLE `fngs_wsal_metadata` (
  `id` bigint(20) NOT NULL,
  `occurrence_id` bigint(20) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_wsal_occurrences`
--

CREATE TABLE `fngs_wsal_occurrences` (
  `id` bigint(20) NOT NULL,
  `site_id` bigint(20) NOT NULL,
  `alert_id` bigint(20) NOT NULL,
  `created_on` double NOT NULL,
  `client_ip` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `severity` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `object` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `event_type` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_roles` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `session_id` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_status` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_type` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_yoast_indexable`
--

CREATE TABLE `fngs_yoast_indexable` (
  `id` int(11) UNSIGNED NOT NULL,
  `permalink` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `permalink_hash` varchar(40) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `object_id` bigint(20) DEFAULT NULL,
  `object_type` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `object_sub_type` varchar(32) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `author_id` bigint(20) DEFAULT NULL,
  `post_parent` bigint(20) DEFAULT NULL,
  `title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `breadcrumb_title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `post_status` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT NULL,
  `is_protected` tinyint(1) DEFAULT 0,
  `has_public_posts` tinyint(1) DEFAULT NULL,
  `number_of_pages` int(11) UNSIGNED DEFAULT NULL,
  `canonical` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `primary_focus_keyword` varchar(191) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `primary_focus_keyword_score` int(3) DEFAULT NULL,
  `readability_score` int(3) DEFAULT NULL,
  `is_cornerstone` tinyint(1) DEFAULT 0,
  `is_robots_noindex` tinyint(1) DEFAULT 0,
  `is_robots_nofollow` tinyint(1) DEFAULT 0,
  `is_robots_noarchive` tinyint(1) DEFAULT 0,
  `is_robots_noimageindex` tinyint(1) DEFAULT 0,
  `is_robots_nosnippet` tinyint(1) DEFAULT 0,
  `twitter_title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_image` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_description` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_image_id` varchar(191) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_image_source` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `open_graph_title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `open_graph_description` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `open_graph_image` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `open_graph_image_id` varchar(191) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `open_graph_image_source` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `open_graph_image_meta` mediumtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `link_count` int(11) DEFAULT NULL,
  `incoming_link_count` int(11) DEFAULT NULL,
  `prominent_words_version` int(11) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `blog_id` bigint(20) NOT NULL DEFAULT 1,
  `language` varchar(32) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `region` varchar(32) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `schema_page_type` varchar(64) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `schema_article_type` varchar(64) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `has_ancestors` tinyint(1) DEFAULT 0,
  `estimated_reading_time_minutes` int(11) DEFAULT NULL,
  `version` int(11) DEFAULT 1,
  `object_last_modified` datetime DEFAULT NULL,
  `object_published_at` datetime DEFAULT NULL,
  `inclusive_language_score` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_yoast_indexable_hierarchy`
--

CREATE TABLE `fngs_yoast_indexable_hierarchy` (
  `indexable_id` int(11) UNSIGNED NOT NULL,
  `ancestor_id` int(11) UNSIGNED NOT NULL,
  `depth` int(11) UNSIGNED DEFAULT NULL,
  `blog_id` bigint(20) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_yoast_migrations`
--

CREATE TABLE `fngs_yoast_migrations` (
  `id` int(11) UNSIGNED NOT NULL,
  `version` varchar(191) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_yoast_primary_term`
--

CREATE TABLE `fngs_yoast_primary_term` (
  `id` int(11) UNSIGNED NOT NULL,
  `post_id` bigint(20) DEFAULT NULL,
  `term_id` bigint(20) DEFAULT NULL,
  `taxonomy` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `blog_id` bigint(20) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fngs_yoast_seo_links`
--

CREATE TABLE `fngs_yoast_seo_links` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `post_id` bigint(20) UNSIGNED DEFAULT NULL,
  `target_post_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` varchar(8) DEFAULT NULL,
  `indexable_id` int(11) UNSIGNED DEFAULT NULL,
  `target_indexable_id` int(11) UNSIGNED DEFAULT NULL,
  `height` int(11) UNSIGNED DEFAULT NULL,
  `width` int(11) UNSIGNED DEFAULT NULL,
  `size` int(11) UNSIGNED DEFAULT NULL,
  `language` varchar(32) DEFAULT NULL,
  `region` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fngs_actionscheduler_actions`
--
ALTER TABLE `fngs_actionscheduler_actions`
  ADD PRIMARY KEY (`action_id`),
  ADD KEY `hook` (`hook`),
  ADD KEY `status` (`status`),
  ADD KEY `scheduled_date_gmt` (`scheduled_date_gmt`),
  ADD KEY `args` (`args`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `last_attempt_gmt` (`last_attempt_gmt`),
  ADD KEY `claim_id_status_scheduled_date_gmt` (`claim_id`,`status`,`scheduled_date_gmt`),
  ADD KEY `hook_status_scheduled_date_gmt` (`hook`(163),`status`,`scheduled_date_gmt`),
  ADD KEY `status_scheduled_date_gmt` (`status`,`scheduled_date_gmt`);

--
-- Indexes for table `fngs_actionscheduler_claims`
--
ALTER TABLE `fngs_actionscheduler_claims`
  ADD PRIMARY KEY (`claim_id`),
  ADD KEY `date_created_gmt` (`date_created_gmt`);

--
-- Indexes for table `fngs_actionscheduler_groups`
--
ALTER TABLE `fngs_actionscheduler_groups`
  ADD PRIMARY KEY (`group_id`),
  ADD KEY `slug` (`slug`(191));

--
-- Indexes for table `fngs_actionscheduler_logs`
--
ALTER TABLE `fngs_actionscheduler_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `action_id` (`action_id`),
  ADD KEY `log_date_gmt` (`log_date_gmt`);

--
-- Indexes for table `fngs_affiliate_wp_affiliatemeta`
--
ALTER TABLE `fngs_affiliate_wp_affiliatemeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `affiliate_id` (`affiliate_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `fngs_affiliate_wp_affiliates`
--
ALTER TABLE `fngs_affiliate_wp_affiliates`
  ADD PRIMARY KEY (`affiliate_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `fngs_affiliate_wp_campaigns`
--
ALTER TABLE `fngs_affiliate_wp_campaigns`
  ADD PRIMARY KEY (`campaign_id`),
  ADD KEY `affiliate_id` (`affiliate_id`),
  ADD KEY `hash` (`hash`);

--
-- Indexes for table `fngs_affiliate_wp_connections`
--
ALTER TABLE `fngs_affiliate_wp_connections`
  ADD PRIMARY KEY (`connection_id`);

--
-- Indexes for table `fngs_affiliate_wp_coupons`
--
ALTER TABLE `fngs_affiliate_wp_coupons`
  ADD PRIMARY KEY (`coupon_id`),
  ADD KEY `coupon_code` (`coupon_code`);

--
-- Indexes for table `fngs_affiliate_wp_creativemeta`
--
ALTER TABLE `fngs_affiliate_wp_creativemeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `creative_id` (`creative_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `fngs_affiliate_wp_creatives`
--
ALTER TABLE `fngs_affiliate_wp_creatives`
  ADD PRIMARY KEY (`creative_id`),
  ADD KEY `creative_id` (`creative_id`);

--
-- Indexes for table `fngs_affiliate_wp_customermeta`
--
ALTER TABLE `fngs_affiliate_wp_customermeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `affwp_customer_id` (`affwp_customer_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `fngs_affiliate_wp_customers`
--
ALTER TABLE `fngs_affiliate_wp_customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `fngs_affiliate_wp_custom_links`
--
ALTER TABLE `fngs_affiliate_wp_custom_links`
  ADD PRIMARY KEY (`custom_link_id`),
  ADD KEY `custom_link_id` (`custom_link_id`);

--
-- Indexes for table `fngs_affiliate_wp_groups`
--
ALTER TABLE `fngs_affiliate_wp_groups`
  ADD PRIMARY KEY (`group_id`);

--
-- Indexes for table `fngs_affiliate_wp_lifetime_customers`
--
ALTER TABLE `fngs_affiliate_wp_lifetime_customers`
  ADD PRIMARY KEY (`lifetime_customer_id`),
  ADD KEY `affwp_customer_id` (`affwp_customer_id`);

--
-- Indexes for table `fngs_affiliate_wp_notifications`
--
ALTER TABLE `fngs_affiliate_wp_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dismissed_start_end` (`dismissed`,`start`,`end`);

--
-- Indexes for table `fngs_affiliate_wp_payouts`
--
ALTER TABLE `fngs_affiliate_wp_payouts`
  ADD PRIMARY KEY (`payout_id`),
  ADD KEY `affiliate_id` (`affiliate_id`),
  ADD KEY `service_id` (`service_id`);

--
-- Indexes for table `fngs_affiliate_wp_referralmeta`
--
ALTER TABLE `fngs_affiliate_wp_referralmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `referral_id` (`referral_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `fngs_affiliate_wp_referrals`
--
ALTER TABLE `fngs_affiliate_wp_referrals`
  ADD PRIMARY KEY (`referral_id`),
  ADD KEY `affiliate_id` (`affiliate_id`);

--
-- Indexes for table `fngs_affiliate_wp_rest_consumers`
--
ALTER TABLE `fngs_affiliate_wp_rest_consumers`
  ADD PRIMARY KEY (`consumer_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `fngs_affiliate_wp_sales`
--
ALTER TABLE `fngs_affiliate_wp_sales`
  ADD PRIMARY KEY (`referral_id`),
  ADD KEY `affiliate_id` (`affiliate_id`);

--
-- Indexes for table `fngs_affiliate_wp_visits`
--
ALTER TABLE `fngs_affiliate_wp_visits`
  ADD PRIMARY KEY (`visit_id`),
  ADD KEY `affiliate_id` (`affiliate_id`);

--
-- Indexes for table `fngs_aioseo_cache`
--
ALTER TABLE `fngs_aioseo_cache`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ndx_aioseo_cache_key` (`key`),
  ADD KEY `ndx_aioseo_cache_expiration` (`expiration`);

--
-- Indexes for table `fngs_aioseo_notifications`
--
ALTER TABLE `fngs_aioseo_notifications`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ndx_aioseo_notifications_slug` (`slug`),
  ADD KEY `ndx_aioseo_notifications_dates` (`start`,`end`),
  ADD KEY `ndx_aioseo_notifications_type` (`type`),
  ADD KEY `ndx_aioseo_notifications_dismissed` (`dismissed`);

--
-- Indexes for table `fngs_aioseo_posts`
--
ALTER TABLE `fngs_aioseo_posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ndx_aioseo_posts_post_id` (`post_id`);

--
-- Indexes for table `fngs_bb_background_job_queue`
--
ALTER TABLE `fngs_bb_background_job_queue`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type` (`type`),
  ADD KEY `group` (`group`),
  ADD KEY `data_id` (`data_id`),
  ADD KEY `secondary_data_id` (`secondary_data_id`),
  ADD KEY `priority` (`priority`),
  ADD KEY `blog_id` (`blog_id`),
  ADD KEY `date_created` (`date_created`);

--
-- Indexes for table `fngs_bb_background_process_logs`
--
ALTER TABLE `fngs_bb_background_process_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `process_start_date_gmt` (`process_start_date_gmt`);

--
-- Indexes for table `fngs_bb_email_queue`
--
ALTER TABLE `fngs_bb_email_queue`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fngs_bb_notifications_subscriptions`
--
ALTER TABLE `fngs_bb_notifications_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_id` (`blog_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `type` (`type`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `secondary_item_id` (`secondary_item_id`),
  ADD KEY `status` (`status`),
  ADD KEY `date_recorded` (`date_recorded`);

--
-- Indexes for table `fngs_bb_polls`
--
ALTER TABLE `fngs_bb_polls`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `item_type` (`item_type`),
  ADD KEY `secondary_item_id` (`secondary_item_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `date_recorded` (`date_recorded`),
  ADD KEY `date_updated` (`date_updated`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `fngs_bb_poll_options`
--
ALTER TABLE `fngs_bb_poll_options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `poll_id` (`poll_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `option_title` (`option_title`),
  ADD KEY `option_order` (`option_order`),
  ADD KEY `date_recorded` (`date_recorded`),
  ADD KEY `date_updated` (`date_updated`);

--
-- Indexes for table `fngs_bb_poll_votes`
--
ALTER TABLE `fngs_bb_poll_votes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `poll_id` (`poll_id`),
  ADD KEY `option_id` (`option_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `date_recorded` (`date_recorded`);

--
-- Indexes for table `fngs_bb_reactions_data`
--
ALTER TABLE `fngs_bb_reactions_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`),
  ADD KEY `rel1` (`rel1`),
  ADD KEY `rel2` (`rel2`),
  ADD KEY `rel3` (`rel3`),
  ADD KEY `date` (`date`);

--
-- Indexes for table `fngs_bb_social_sign_on_users`
--
ALTER TABLE `fngs_bb_social_sign_on_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wp_user_id` (`wp_user_id`,`type`),
  ADD KEY `identifier` (`identifier`),
  ADD KEY `first_name` (`first_name`),
  ADD KEY `last_name` (`last_name`);

--
-- Indexes for table `fngs_bb_user_reactions`
--
ALTER TABLE `fngs_bb_user_reactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `reaction_id` (`reaction_id`),
  ADD KEY `item_type` (`item_type`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `date_created` (`date_created`);

--
-- Indexes for table `fngs_bb_xprofile_visibility`
--
ALTER TABLE `fngs_bb_xprofile_visibility`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_field_id_user_id` (`field_id`,`user_id`),
  ADD KEY `field_id` (`field_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `value` (`value`);

--
-- Indexes for table `fngs_bp_activity`
--
ALTER TABLE `fngs_bp_activity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `date_recorded` (`date_recorded`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `secondary_item_id` (`secondary_item_id`),
  ADD KEY `component` (`component`),
  ADD KEY `type` (`type`),
  ADD KEY `mptt_left` (`mptt_left`),
  ADD KEY `mptt_right` (`mptt_right`),
  ADD KEY `hide_sitewide` (`hide_sitewide`),
  ADD KEY `is_spam` (`is_spam`),
  ADD KEY `date_updated` (`date_updated`);

--
-- Indexes for table `fngs_bp_activity_meta`
--
ALTER TABLE `fngs_bp_activity_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `activity_id` (`activity_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `fngs_bp_document`
--
ALTER TABLE `fngs_bp_document`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attachment_id` (`attachment_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `folder_id` (`folder_id`),
  ADD KEY `document_author_id` (`folder_id`,`user_id`),
  ADD KEY `activity_id` (`activity_id`),
  ADD KEY `blog_id` (`blog_id`),
  ADD KEY `message_id` (`message_id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `privacy` (`privacy`),
  ADD KEY `menu_order` (`menu_order`),
  ADD KEY `date_created` (`date_created`),
  ADD KEY `date_modified` (`date_modified`),
  ADD KEY `blog_id_2` (`blog_id`),
  ADD KEY `message_id_2` (`message_id`),
  ADD KEY `group_id_2` (`group_id`),
  ADD KEY `privacy_2` (`privacy`),
  ADD KEY `menu_order_2` (`menu_order`),
  ADD KEY `date_created_2` (`date_created`),
  ADD KEY `date_modified_2` (`date_modified`);

--
-- Indexes for table `fngs_bp_document_folder`
--
ALTER TABLE `fngs_bp_document_folder`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fngs_bp_document_folder_meta`
--
ALTER TABLE `fngs_bp_document_folder_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `folder_id` (`folder_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `fngs_bp_document_meta`
--
ALTER TABLE `fngs_bp_document_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `document_id` (`document_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `fngs_bp_follow`
--
ALTER TABLE `fngs_bp_follow`
  ADD PRIMARY KEY (`id`),
  ADD KEY `followers` (`leader_id`,`follower_id`);

--
-- Indexes for table `fngs_bp_friends`
--
ALTER TABLE `fngs_bp_friends`
  ADD PRIMARY KEY (`id`),
  ADD KEY `initiator_user_id` (`initiator_user_id`),
  ADD KEY `friend_user_id` (`friend_user_id`);

--
-- Indexes for table `fngs_bp_groups`
--
ALTER TABLE `fngs_bp_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `creator_id` (`creator_id`),
  ADD KEY `status` (`status`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `fngs_bp_groups_groupmeta`
--
ALTER TABLE `fngs_bp_groups_groupmeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `fngs_bp_groups_membermeta`
--
ALTER TABLE `fngs_bp_groups_membermeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_id` (`member_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `fngs_bp_groups_members`
--
ALTER TABLE `fngs_bp_groups_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `is_admin` (`is_admin`),
  ADD KEY `is_mod` (`is_mod`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `inviter_id` (`inviter_id`),
  ADD KEY `is_confirmed` (`is_confirmed`);

--
-- Indexes for table `fngs_bp_invitations`
--
ALTER TABLE `fngs_bp_invitations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `inviter_id` (`inviter_id`),
  ADD KEY `invitee_email` (`invitee_email`),
  ADD KEY `class` (`class`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `secondary_item_id` (`secondary_item_id`),
  ADD KEY `type` (`type`),
  ADD KEY `invite_sent` (`invite_sent`),
  ADD KEY `accepted` (`accepted`);

--
-- Indexes for table `fngs_bp_invitations_invitemeta`
--
ALTER TABLE `fngs_bp_invitations_invitemeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invite_id` (`invite_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `fngs_bp_media`
--
ALTER TABLE `fngs_bp_media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attachment_id` (`attachment_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `album_id` (`album_id`),
  ADD KEY `media_author_id` (`album_id`,`user_id`),
  ADD KEY `activity_id` (`activity_id`),
  ADD KEY `blog_id` (`blog_id`),
  ADD KEY `message_id` (`message_id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `privacy` (`privacy`),
  ADD KEY `type` (`type`),
  ADD KEY `menu_order` (`menu_order`),
  ADD KEY `date_created` (`date_created`),
  ADD KEY `blog_id_2` (`blog_id`),
  ADD KEY `message_id_2` (`message_id`),
  ADD KEY `group_id_2` (`group_id`),
  ADD KEY `privacy_2` (`privacy`),
  ADD KEY `type_2` (`type`),
  ADD KEY `menu_order_2` (`menu_order`),
  ADD KEY `date_created_2` (`date_created`);

--
-- Indexes for table `fngs_bp_media_albums`
--
ALTER TABLE `fngs_bp_media_albums`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fngs_bp_messages_messages`
--
ALTER TABLE `fngs_bp_messages_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `thread_id` (`thread_id`);

--
-- Indexes for table `fngs_bp_messages_meta`
--
ALTER TABLE `fngs_bp_messages_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `message_id` (`message_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `fngs_bp_messages_notices`
--
ALTER TABLE `fngs_bp_messages_notices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `is_active` (`is_active`);

--
-- Indexes for table `fngs_bp_messages_recipients`
--
ALTER TABLE `fngs_bp_messages_recipients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `thread_id` (`thread_id`),
  ADD KEY `is_deleted` (`is_deleted`),
  ADD KEY `sender_only` (`sender_only`),
  ADD KEY `unread_count` (`unread_count`),
  ADD KEY `is_hidden` (`is_hidden`);

--
-- Indexes for table `fngs_bp_moderation`
--
ALTER TABLE `fngs_bp_moderation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `moderation_report_id` (`moderation_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `fngs_bp_moderation_meta`
--
ALTER TABLE `fngs_bp_moderation_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `moderation_id` (`moderation_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `fngs_bp_notifications`
--
ALTER TABLE `fngs_bp_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `secondary_item_id` (`secondary_item_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `is_new` (`is_new`),
  ADD KEY `component_name` (`component_name`),
  ADD KEY `component_action` (`component_action`),
  ADD KEY `useritem` (`user_id`,`is_new`);

--
-- Indexes for table `fngs_bp_notifications_meta`
--
ALTER TABLE `fngs_bp_notifications_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notification_id` (`notification_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `fngs_bp_optouts`
--
ALTER TABLE `fngs_bp_optouts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `email_type` (`email_type`),
  ADD KEY `date_modified` (`date_modified`);

--
-- Indexes for table `fngs_bp_suspend`
--
ALTER TABLE `fngs_bp_suspend`
  ADD PRIMARY KEY (`id`),
  ADD KEY `suspend_item_id` (`item_id`,`item_type`,`blog_id`),
  ADD KEY `suspend_item` (`item_id`,`item_type`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `user_suspended` (`user_suspended`),
  ADD KEY `hide_parent` (`hide_parent`),
  ADD KEY `hide_sitewide` (`hide_sitewide`),
  ADD KEY `suspend_conditions` (`user_suspended`,`hide_parent`,`hide_sitewide`);

--
-- Indexes for table `fngs_bp_suspend_details`
--
ALTER TABLE `fngs_bp_suspend_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `suspend_details_id` (`suspend_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `fngs_bp_suspend_meta`
--
ALTER TABLE `fngs_bp_suspend_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `suspend_id` (`suspend_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `fngs_bp_xprofile_data`
--
ALTER TABLE `fngs_bp_xprofile_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `field_id` (`field_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `fngs_bp_xprofile_fields`
--
ALTER TABLE `fngs_bp_xprofile_fields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `field_order` (`field_order`),
  ADD KEY `can_delete` (`can_delete`),
  ADD KEY `is_required` (`is_required`);

--
-- Indexes for table `fngs_bp_xprofile_groups`
--
ALTER TABLE `fngs_bp_xprofile_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `can_delete` (`can_delete`);

--
-- Indexes for table `fngs_bp_xprofile_meta`
--
ALTER TABLE `fngs_bp_xprofile_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `object_id` (`object_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `fngs_bp_zoom_meetings`
--
ALTER TABLE `fngs_bp_zoom_meetings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `activity_id` (`activity_id`),
  ADD KEY `meeting_id` (`meeting_id`);

--
-- Indexes for table `fngs_bp_zoom_meeting_meta`
--
ALTER TABLE `fngs_bp_zoom_meeting_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meeting_id` (`meeting_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `fngs_bp_zoom_recordings`
--
ALTER TABLE `fngs_bp_zoom_recordings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recording_id` (`recording_id`),
  ADD KEY `meeting_id` (`meeting_id`);

--
-- Indexes for table `fngs_bp_zoom_webinars`
--
ALTER TABLE `fngs_bp_zoom_webinars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `activity_id` (`activity_id`),
  ADD KEY `webinar_id` (`webinar_id`);

--
-- Indexes for table `fngs_bp_zoom_webinar_meta`
--
ALTER TABLE `fngs_bp_zoom_webinar_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `webinar_id` (`webinar_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `fngs_bp_zoom_webinar_recordings`
--
ALTER TABLE `fngs_bp_zoom_webinar_recordings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recording_id` (`recording_id`),
  ADD KEY `webinar_id` (`webinar_id`);

--
-- Indexes for table `fngs_commentmeta`
--
ALTER TABLE `fngs_commentmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `comment_id` (`comment_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `fngs_comments`
--
ALTER TABLE `fngs_comments`
  ADD PRIMARY KEY (`comment_ID`),
  ADD KEY `comment_post_ID` (`comment_post_ID`),
  ADD KEY `comment_approved_date_gmt` (`comment_approved`,`comment_date_gmt`),
  ADD KEY `comment_date_gmt` (`comment_date_gmt`),
  ADD KEY `comment_parent` (`comment_parent`),
  ADD KEY `comment_author_email` (`comment_author_email`(10)),
  ADD KEY `woo_idx_comment_type` (`comment_type`);

--
-- Indexes for table `fngs_e_events`
--
ALTER TABLE `fngs_e_events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_at_index` (`created_at`);

--
-- Indexes for table `fngs_e_notes`
--
ALTER TABLE `fngs_e_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `route_url_index` (`route_url`(191)),
  ADD KEY `post_id_index` (`post_id`),
  ADD KEY `element_id_index` (`element_id`),
  ADD KEY `parent_id_index` (`parent_id`),
  ADD KEY `author_id_index` (`author_id`),
  ADD KEY `status_index` (`status`),
  ADD KEY `is_resolved_index` (`is_resolved`),
  ADD KEY `is_public_index` (`is_public`),
  ADD KEY `created_at_index` (`created_at`),
  ADD KEY `updated_at_index` (`updated_at`),
  ADD KEY `last_activity_at_index` (`last_activity_at`);

--
-- Indexes for table `fngs_e_notes_users_relations`
--
ALTER TABLE `fngs_e_notes_users_relations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type_index` (`type`),
  ADD KEY `note_id_index` (`note_id`),
  ADD KEY `user_id_index` (`user_id`);

--
-- Indexes for table `fngs_e_submissions`
--
ALTER TABLE `fngs_e_submissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `hash_id_unique_index` (`hash_id`),
  ADD KEY `main_meta_id_index` (`main_meta_id`),
  ADD KEY `hash_id_index` (`hash_id`),
  ADD KEY `type_index` (`type`),
  ADD KEY `post_id_index` (`post_id`),
  ADD KEY `element_id_index` (`element_id`),
  ADD KEY `campaign_id_index` (`campaign_id`),
  ADD KEY `user_id_index` (`user_id`),
  ADD KEY `user_ip_index` (`user_ip`),
  ADD KEY `status_index` (`status`),
  ADD KEY `is_read_index` (`is_read`),
  ADD KEY `created_at_gmt_index` (`created_at_gmt`),
  ADD KEY `updated_at_gmt_index` (`updated_at_gmt`),
  ADD KEY `created_at_index` (`created_at`),
  ADD KEY `updated_at_index` (`updated_at`),
  ADD KEY `referer_index` (`referer`(191)),
  ADD KEY `referer_title_index` (`referer_title`(191));

--
-- Indexes for table `fngs_e_submissions_actions_log`
--
ALTER TABLE `fngs_e_submissions_actions_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submission_id_index` (`submission_id`),
  ADD KEY `action_name_index` (`action_name`),
  ADD KEY `status_index` (`status`),
  ADD KEY `created_at_gmt_index` (`created_at_gmt`),
  ADD KEY `updated_at_gmt_index` (`updated_at_gmt`),
  ADD KEY `created_at_index` (`created_at`),
  ADD KEY `updated_at_index` (`updated_at`);

--
-- Indexes for table `fngs_e_submissions_values`
--
ALTER TABLE `fngs_e_submissions_values`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submission_id_index` (`submission_id`),
  ADD KEY `key_index` (`key`);

--
-- Indexes for table `fngs_facetwp_index`
--
ALTER TABLE `fngs_facetwp_index`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id_idx` (`post_id`),
  ADD KEY `facet_name_idx` (`facet_name`),
  ADD KEY `facet_name_value_idx` (`facet_name`,`facet_value`);

--
-- Indexes for table `fngs_gf_addon_feed`
--
ALTER TABLE `fngs_gf_addon_feed`
  ADD PRIMARY KEY (`id`),
  ADD KEY `addon_form` (`addon_slug`,`form_id`);

--
-- Indexes for table `fngs_gf_addon_payment_transaction`
--
ALTER TABLE `fngs_gf_addon_payment_transaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lead_id` (`lead_id`),
  ADD KEY `transaction_type` (`transaction_type`),
  ADD KEY `type_lead` (`lead_id`,`transaction_type`);

--
-- Indexes for table `fngs_gf_draft_submissions`
--
ALTER TABLE `fngs_gf_draft_submissions`
  ADD PRIMARY KEY (`uuid`),
  ADD KEY `form_id` (`form_id`);

--
-- Indexes for table `fngs_gf_entry`
--
ALTER TABLE `fngs_gf_entry`
  ADD PRIMARY KEY (`id`),
  ADD KEY `form_id` (`form_id`),
  ADD KEY `form_id_status` (`form_id`,`status`);

--
-- Indexes for table `fngs_gf_entry_meta`
--
ALTER TABLE `fngs_gf_entry_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meta_key` (`meta_key`(191)),
  ADD KEY `entry_id` (`entry_id`),
  ADD KEY `meta_value` (`meta_value`(191));

--
-- Indexes for table `fngs_gf_entry_notes`
--
ALTER TABLE `fngs_gf_entry_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `entry_id` (`entry_id`),
  ADD KEY `entry_user_key` (`entry_id`,`user_id`);

--
-- Indexes for table `fngs_gf_form`
--
ALTER TABLE `fngs_gf_form`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fngs_gf_form_meta`
--
ALTER TABLE `fngs_gf_form_meta`
  ADD PRIMARY KEY (`form_id`);

--
-- Indexes for table `fngs_gf_form_revisions`
--
ALTER TABLE `fngs_gf_form_revisions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `date_created` (`date_created`),
  ADD KEY `form_id` (`form_id`);

--
-- Indexes for table `fngs_gf_form_view`
--
ALTER TABLE `fngs_gf_form_view`
  ADD PRIMARY KEY (`id`),
  ADD KEY `date_created` (`date_created`),
  ADD KEY `form_id` (`form_id`);

--
-- Indexes for table `fngs_gf_rest_api_keys`
--
ALTER TABLE `fngs_gf_rest_api_keys`
  ADD PRIMARY KEY (`key_id`),
  ADD KEY `consumer_key` (`consumer_key`),
  ADD KEY `consumer_secret` (`consumer_secret`);

--
-- Indexes for table `fngs_links`
--
ALTER TABLE `fngs_links`
  ADD PRIMARY KEY (`link_id`),
  ADD KEY `link_visible` (`link_visible`);

--
-- Indexes for table `fngs_options`
--
ALTER TABLE `fngs_options`
  ADD PRIMARY KEY (`option_id`),
  ADD UNIQUE KEY `option_name` (`option_name`),
  ADD KEY `autoload` (`autoload`);

--
-- Indexes for table `fngs_pmxi_files`
--
ALTER TABLE `fngs_pmxi_files`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fngs_pmxi_geocoding`
--
ALTER TABLE `fngs_pmxi_geocoding`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_address` (`address`(255)),
  ADD KEY `idx_coordinates` (`latitude`,`longitude`);

--
-- Indexes for table `fngs_pmxi_hash`
--
ALTER TABLE `fngs_pmxi_hash`
  ADD PRIMARY KEY (`hash`);

--
-- Indexes for table `fngs_pmxi_history`
--
ALTER TABLE `fngs_pmxi_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fngs_pmxi_images`
--
ALTER TABLE `fngs_pmxi_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fngs_pmxi_imports`
--
ALTER TABLE `fngs_pmxi_imports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fngs_pmxi_posts`
--
ALTER TABLE `fngs_pmxi_posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fngs_pmxi_templates`
--
ALTER TABLE `fngs_pmxi_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fngs_postmeta`
--
ALTER TABLE `fngs_postmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `fngs_posts`
--
ALTER TABLE `fngs_posts`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `post_name` (`post_name`(191)),
  ADD KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  ADD KEY `post_parent` (`post_parent`),
  ADD KEY `post_author` (`post_author`);
ALTER TABLE `fngs_posts` ADD FULLTEXT KEY `crp_related` (`post_title`,`post_content`);
ALTER TABLE `fngs_posts` ADD FULLTEXT KEY `crp_related_title` (`post_title`);
ALTER TABLE `fngs_posts` ADD FULLTEXT KEY `crp_related_content` (`post_content`);

--
-- Indexes for table `fngs_post_smtp_logmeta`
--
ALTER TABLE `fngs_post_smtp_logmeta`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fngs_post_smtp_logs`
--
ALTER TABLE `fngs_post_smtp_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fngs_pronamic_pay_mollie_customers`
--
ALTER TABLE `fngs_pronamic_pay_mollie_customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mollie_id` (`mollie_id`),
  ADD KEY `organization_id` (`organization_id`),
  ADD KEY `profile_id` (`profile_id`),
  ADD KEY `test_mode` (`test_mode`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `fngs_pronamic_pay_mollie_customer_users`
--
ALTER TABLE `fngs_pronamic_pay_mollie_customer_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customer_user` (`customer_id`,`user_id`),
  ADD KEY `fk_customer_user_id` (`user_id`);

--
-- Indexes for table `fngs_pronamic_pay_mollie_organizations`
--
ALTER TABLE `fngs_pronamic_pay_mollie_organizations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mollie_id` (`mollie_id`);

--
-- Indexes for table `fngs_pronamic_pay_mollie_profiles`
--
ALTER TABLE `fngs_pronamic_pay_mollie_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mollie_id` (`mollie_id`),
  ADD KEY `organization_id` (`organization_id`);

--
-- Indexes for table `fngs_rp4wp_cache`
--
ALTER TABLE `fngs_rp4wp_cache`
  ADD PRIMARY KEY (`post_id`,`word`);

--
-- Indexes for table `fngs_rtwapwcm_mlm`
--
ALTER TABLE `fngs_rtwapwcm_mlm`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fngs_rtwapwcm_referrals`
--
ALTER TABLE `fngs_rtwapwcm_referrals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fngs_rtwapwcm_referral_link`
--
ALTER TABLE `fngs_rtwapwcm_referral_link`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fngs_rtwapwcm_visitors_track`
--
ALTER TABLE `fngs_rtwapwcm_visitors_track`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fngs_rtwapwcm_wallet_transaction`
--
ALTER TABLE `fngs_rtwapwcm_wallet_transaction`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fngs_signups`
--
ALTER TABLE `fngs_signups`
  ADD PRIMARY KEY (`signup_id`),
  ADD KEY `activation_key` (`activation_key`),
  ADD KEY `user_email` (`user_email`),
  ADD KEY `user_login_email` (`user_login`,`user_email`),
  ADD KEY `domain_path` (`domain`(140),`path`(51));

--
-- Indexes for table `fngs_termmeta`
--
ALTER TABLE `fngs_termmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `term_id` (`term_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `fngs_terms`
--
ALTER TABLE `fngs_terms`
  ADD PRIMARY KEY (`term_id`),
  ADD KEY `slug` (`slug`(191)),
  ADD KEY `name` (`name`(191));

--
-- Indexes for table `fngs_term_relationships`
--
ALTER TABLE `fngs_term_relationships`
  ADD PRIMARY KEY (`object_id`,`term_taxonomy_id`),
  ADD KEY `term_taxonomy_id` (`term_taxonomy_id`);

--
-- Indexes for table `fngs_term_taxonomy`
--
ALTER TABLE `fngs_term_taxonomy`
  ADD PRIMARY KEY (`term_taxonomy_id`),
  ADD UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  ADD KEY `taxonomy` (`taxonomy`);

--
-- Indexes for table `fngs_uap_action_log`
--
ALTER TABLE `fngs_uap_action_log`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `completed` (`completed`),
  ADD KEY `automator_action_id` (`automator_action_id`),
  ADD KEY `automator_recipe_log_id` (`automator_recipe_log_id`),
  ADD KEY `automator_recipe_id` (`automator_recipe_id`);

--
-- Indexes for table `fngs_uap_action_log_meta`
--
ALTER TABLE `fngs_uap_action_log_meta`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `automator_action_log_id` (`automator_action_log_id`),
  ADD KEY `automator_action_id` (`automator_action_id`),
  ADD KEY `meta_key` (`meta_key`(20));

--
-- Indexes for table `fngs_uap_api_log`
--
ALTER TABLE `fngs_uap_api_log`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `item_log_id` (`item_log_id`);

--
-- Indexes for table `fngs_uap_closure_log`
--
ALTER TABLE `fngs_uap_closure_log`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `automator_recipe_id` (`automator_recipe_id`),
  ADD KEY `automator_closure_id` (`automator_closure_id`),
  ADD KEY `completed` (`completed`);

--
-- Indexes for table `fngs_uap_closure_log_meta`
--
ALTER TABLE `fngs_uap_closure_log_meta`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `automator_closure_id` (`automator_closure_id`),
  ADD KEY `meta_key` (`meta_key`(15));

--
-- Indexes for table `fngs_uap_recipe_log`
--
ALTER TABLE `fngs_uap_recipe_log`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `completed` (`completed`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `automator_recipe_id` (`automator_recipe_id`);

--
-- Indexes for table `fngs_uap_trigger_log`
--
ALTER TABLE `fngs_uap_trigger_log`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `completed` (`completed`),
  ADD KEY `automator_recipe_id` (`automator_recipe_id`),
  ADD KEY `automator_trigger_id` (`automator_trigger_id`),
  ADD KEY `automator_recipe_log_id` (`automator_recipe_log_id`);

--
-- Indexes for table `fngs_uap_trigger_log_meta`
--
ALTER TABLE `fngs_uap_trigger_log_meta`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `run_number` (`run_number`),
  ADD KEY `automator_trigger_id` (`automator_trigger_id`),
  ADD KEY `automator_trigger_log_id` (`automator_trigger_log_id`),
  ADD KEY `meta_key` (`meta_key`(20));

--
-- Indexes for table `fngs_usermeta`
--
ALTER TABLE `fngs_usermeta`
  ADD PRIMARY KEY (`umeta_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `fngs_users`
--
ALTER TABLE `fngs_users`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_login_key` (`user_login`),
  ADD KEY `user_nicename` (`user_nicename`),
  ADD KEY `user_email` (`user_email`);

--
-- Indexes for table `fngs_wc_admin_notes`
--
ALTER TABLE `fngs_wc_admin_notes`
  ADD PRIMARY KEY (`note_id`);

--
-- Indexes for table `fngs_wc_admin_note_actions`
--
ALTER TABLE `fngs_wc_admin_note_actions`
  ADD PRIMARY KEY (`action_id`),
  ADD KEY `note_id` (`note_id`);

--
-- Indexes for table `fngs_wc_category_lookup`
--
ALTER TABLE `fngs_wc_category_lookup`
  ADD PRIMARY KEY (`category_tree_id`,`category_id`);

--
-- Indexes for table `fngs_wc_customer_lookup`
--
ALTER TABLE `fngs_wc_customer_lookup`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `fngs_wc_download_log`
--
ALTER TABLE `fngs_wc_download_log`
  ADD PRIMARY KEY (`download_log_id`),
  ADD KEY `permission_id` (`permission_id`),
  ADD KEY `timestamp` (`timestamp`);

--
-- Indexes for table `fngs_wc_orders`
--
ALTER TABLE `fngs_wc_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status` (`status`),
  ADD KEY `date_created` (`date_created_gmt`),
  ADD KEY `customer_id_billing_email` (`customer_id`,`billing_email`(171)),
  ADD KEY `billing_email` (`billing_email`(191)),
  ADD KEY `type_status_date` (`type`,`status`,`date_created_gmt`),
  ADD KEY `parent_order_id` (`parent_order_id`),
  ADD KEY `date_updated` (`date_updated_gmt`);

--
-- Indexes for table `fngs_wc_orders_meta`
--
ALTER TABLE `fngs_wc_orders_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meta_key_value` (`meta_key`(100),`meta_value`(82)),
  ADD KEY `order_id_meta_key_meta_value` (`order_id`,`meta_key`(100),`meta_value`(82));

--
-- Indexes for table `fngs_wc_order_addresses`
--
ALTER TABLE `fngs_wc_order_addresses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `address_type_order_id` (`address_type`,`order_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `email` (`email`(191)),
  ADD KEY `phone` (`phone`);

--
-- Indexes for table `fngs_wc_order_coupon_lookup`
--
ALTER TABLE `fngs_wc_order_coupon_lookup`
  ADD PRIMARY KEY (`order_id`,`coupon_id`),
  ADD KEY `coupon_id` (`coupon_id`),
  ADD KEY `date_created` (`date_created`);

--
-- Indexes for table `fngs_wc_order_operational_data`
--
ALTER TABLE `fngs_wc_order_operational_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_id` (`order_id`),
  ADD KEY `order_key` (`order_key`);

--
-- Indexes for table `fngs_wc_order_product_lookup`
--
ALTER TABLE `fngs_wc_order_product_lookup`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `date_created` (`date_created`),
  ADD KEY `customer_product_date` (`customer_id`,`product_id`,`date_created`);

--
-- Indexes for table `fngs_wc_order_stats`
--
ALTER TABLE `fngs_wc_order_stats`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `date_created` (`date_created`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `status` (`status`(191));

--
-- Indexes for table `fngs_wc_order_tax_lookup`
--
ALTER TABLE `fngs_wc_order_tax_lookup`
  ADD PRIMARY KEY (`order_id`,`tax_rate_id`),
  ADD KEY `tax_rate_id` (`tax_rate_id`),
  ADD KEY `date_created` (`date_created`);

--
-- Indexes for table `fngs_wc_product_attributes_lookup`
--
ALTER TABLE `fngs_wc_product_attributes_lookup`
  ADD PRIMARY KEY (`product_or_parent_id`,`term_id`,`product_id`,`taxonomy`),
  ADD KEY `is_variation_attribute_term_id` (`is_variation_attribute`,`term_id`);

--
-- Indexes for table `fngs_wc_product_download_directories`
--
ALTER TABLE `fngs_wc_product_download_directories`
  ADD PRIMARY KEY (`url_id`),
  ADD KEY `url` (`url`(191));

--
-- Indexes for table `fngs_wc_product_meta_lookup`
--
ALTER TABLE `fngs_wc_product_meta_lookup`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `virtual` (`virtual`),
  ADD KEY `downloadable` (`downloadable`),
  ADD KEY `stock_status` (`stock_status`),
  ADD KEY `stock_quantity` (`stock_quantity`),
  ADD KEY `onsale` (`onsale`),
  ADD KEY `min_max_price` (`min_price`,`max_price`),
  ADD KEY `sku` (`sku`(50));

--
-- Indexes for table `fngs_wc_rate_limits`
--
ALTER TABLE `fngs_wc_rate_limits`
  ADD PRIMARY KEY (`rate_limit_id`),
  ADD UNIQUE KEY `rate_limit_key` (`rate_limit_key`(191));

--
-- Indexes for table `fngs_wc_reserved_stock`
--
ALTER TABLE `fngs_wc_reserved_stock`
  ADD PRIMARY KEY (`order_id`,`product_id`);

--
-- Indexes for table `fngs_wc_tax_rate_classes`
--
ALTER TABLE `fngs_wc_tax_rate_classes`
  ADD PRIMARY KEY (`tax_rate_class_id`),
  ADD UNIQUE KEY `slug` (`slug`(191));

--
-- Indexes for table `fngs_wc_webhooks`
--
ALTER TABLE `fngs_wc_webhooks`
  ADD PRIMARY KEY (`webhook_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `fngs_woocommerce_api_keys`
--
ALTER TABLE `fngs_woocommerce_api_keys`
  ADD PRIMARY KEY (`key_id`),
  ADD KEY `consumer_key` (`consumer_key`),
  ADD KEY `consumer_secret` (`consumer_secret`);

--
-- Indexes for table `fngs_woocommerce_attribute_taxonomies`
--
ALTER TABLE `fngs_woocommerce_attribute_taxonomies`
  ADD PRIMARY KEY (`attribute_id`),
  ADD KEY `attribute_name` (`attribute_name`(20));

--
-- Indexes for table `fngs_woocommerce_downloadable_product_permissions`
--
ALTER TABLE `fngs_woocommerce_downloadable_product_permissions`
  ADD PRIMARY KEY (`permission_id`),
  ADD KEY `download_order_key_product` (`product_id`,`order_id`,`order_key`(16),`download_id`),
  ADD KEY `download_order_product` (`download_id`,`order_id`,`product_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `user_order_remaining_expires` (`user_id`,`order_id`,`downloads_remaining`,`access_expires`);

--
-- Indexes for table `fngs_woocommerce_log`
--
ALTER TABLE `fngs_woocommerce_log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `level` (`level`);

--
-- Indexes for table `fngs_woocommerce_order_itemmeta`
--
ALTER TABLE `fngs_woocommerce_order_itemmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `order_item_id` (`order_item_id`),
  ADD KEY `meta_key` (`meta_key`(32));

--
-- Indexes for table `fngs_woocommerce_order_items`
--
ALTER TABLE `fngs_woocommerce_order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `fngs_woocommerce_payment_tokenmeta`
--
ALTER TABLE `fngs_woocommerce_payment_tokenmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `payment_token_id` (`payment_token_id`),
  ADD KEY `meta_key` (`meta_key`(32));

--
-- Indexes for table `fngs_woocommerce_payment_tokens`
--
ALTER TABLE `fngs_woocommerce_payment_tokens`
  ADD PRIMARY KEY (`token_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `fngs_woocommerce_sessions`
--
ALTER TABLE `fngs_woocommerce_sessions`
  ADD PRIMARY KEY (`session_id`),
  ADD UNIQUE KEY `session_key` (`session_key`);

--
-- Indexes for table `fngs_woocommerce_shipping_zones`
--
ALTER TABLE `fngs_woocommerce_shipping_zones`
  ADD PRIMARY KEY (`zone_id`);

--
-- Indexes for table `fngs_woocommerce_shipping_zone_locations`
--
ALTER TABLE `fngs_woocommerce_shipping_zone_locations`
  ADD PRIMARY KEY (`location_id`),
  ADD KEY `zone_id` (`zone_id`),
  ADD KEY `location_type_code` (`location_type`(10),`location_code`(20));

--
-- Indexes for table `fngs_woocommerce_shipping_zone_methods`
--
ALTER TABLE `fngs_woocommerce_shipping_zone_methods`
  ADD PRIMARY KEY (`instance_id`);

--
-- Indexes for table `fngs_woocommerce_tax_rates`
--
ALTER TABLE `fngs_woocommerce_tax_rates`
  ADD PRIMARY KEY (`tax_rate_id`),
  ADD KEY `tax_rate_country` (`tax_rate_country`),
  ADD KEY `tax_rate_state` (`tax_rate_state`(2)),
  ADD KEY `tax_rate_class` (`tax_rate_class`(10)),
  ADD KEY `tax_rate_priority` (`tax_rate_priority`);

--
-- Indexes for table `fngs_woocommerce_tax_rate_locations`
--
ALTER TABLE `fngs_woocommerce_tax_rate_locations`
  ADD PRIMARY KEY (`location_id`),
  ADD KEY `tax_rate_id` (`tax_rate_id`),
  ADD KEY `location_type_code` (`location_type`(10),`location_code`(20));

--
-- Indexes for table `fngs_wpmailsmtp_debug_events`
--
ALTER TABLE `fngs_wpmailsmtp_debug_events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fngs_wpmailsmtp_tasks_meta`
--
ALTER TABLE `fngs_wpmailsmtp_tasks_meta`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fngs_wpr_above_the_fold`
--
ALTER TABLE `fngs_wpr_above_the_fold`
  ADD PRIMARY KEY (`id`),
  ADD KEY `url` (`url`(150),`is_mobile`),
  ADD KEY `modified` (`modified`),
  ADD KEY `last_accessed` (`last_accessed`),
  ADD KEY `status_index` (`status`(191));

--
-- Indexes for table `fngs_wpr_lazy_render_content`
--
ALTER TABLE `fngs_wpr_lazy_render_content`
  ADD PRIMARY KEY (`id`),
  ADD KEY `url` (`url`(150),`is_mobile`),
  ADD KEY `modified` (`modified`),
  ADD KEY `last_accessed` (`last_accessed`),
  ADD KEY `status_index` (`status`(191));

--
-- Indexes for table `fngs_wpr_preconnect_external_domains`
--
ALTER TABLE `fngs_wpr_preconnect_external_domains`
  ADD PRIMARY KEY (`id`),
  ADD KEY `url` (`url`(150),`is_mobile`),
  ADD KEY `modified` (`modified`),
  ADD KEY `last_accessed` (`last_accessed`),
  ADD KEY `status_index` (`status`(191));

--
-- Indexes for table `fngs_wpr_preload_fonts`
--
ALTER TABLE `fngs_wpr_preload_fonts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `url` (`url`(150),`is_mobile`),
  ADD KEY `modified` (`modified`),
  ADD KEY `last_accessed` (`last_accessed`),
  ADD KEY `status_index` (`status`(191));

--
-- Indexes for table `fngs_wpr_rocket_cache`
--
ALTER TABLE `fngs_wpr_rocket_cache`
  ADD PRIMARY KEY (`id`),
  ADD KEY `url` (`url`(191)),
  ADD KEY `modified` (`modified`),
  ADD KEY `last_accessed` (`last_accessed`);

--
-- Indexes for table `fngs_wpr_rucss_used_css`
--
ALTER TABLE `fngs_wpr_rucss_used_css`
  ADD PRIMARY KEY (`id`),
  ADD KEY `url` (`url`(150),`is_mobile`),
  ADD KEY `modified` (`modified`),
  ADD KEY `last_accessed` (`last_accessed`),
  ADD KEY `status_index` (`status`(191)),
  ADD KEY `error_code_index` (`error_code`),
  ADD KEY `hash` (`hash`);

--
-- Indexes for table `fngs_wsal_metadata`
--
ALTER TABLE `fngs_wsal_metadata`
  ADD PRIMARY KEY (`id`),
  ADD KEY `occurrence_name` (`occurrence_id`,`name`),
  ADD KEY `name_value` (`name`,`value`(64));

--
-- Indexes for table `fngs_wsal_occurrences`
--
ALTER TABLE `fngs_wsal_occurrences`
  ADD PRIMARY KEY (`id`),
  ADD KEY `site_alert_created` (`site_id`,`alert_id`,`created_on`),
  ADD KEY `created_on` (`created_on`);

--
-- Indexes for table `fngs_yoast_indexable`
--
ALTER TABLE `fngs_yoast_indexable`
  ADD PRIMARY KEY (`id`),
  ADD KEY `object_type_and_sub_type` (`object_type`,`object_sub_type`),
  ADD KEY `object_id_and_type` (`object_id`,`object_type`),
  ADD KEY `permalink_hash_and_object_type` (`permalink_hash`,`object_type`),
  ADD KEY `subpages` (`post_parent`,`object_type`,`post_status`,`object_id`),
  ADD KEY `prominent_words` (`prominent_words_version`,`object_type`,`object_sub_type`,`post_status`),
  ADD KEY `published_sitemap_index` (`object_published_at`,`is_robots_noindex`,`object_type`,`object_sub_type`);

--
-- Indexes for table `fngs_yoast_indexable_hierarchy`
--
ALTER TABLE `fngs_yoast_indexable_hierarchy`
  ADD PRIMARY KEY (`indexable_id`,`ancestor_id`),
  ADD KEY `indexable_id` (`indexable_id`),
  ADD KEY `ancestor_id` (`ancestor_id`),
  ADD KEY `depth` (`depth`);

--
-- Indexes for table `fngs_yoast_migrations`
--
ALTER TABLE `fngs_yoast_migrations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `fngs_yoast_migrations_version` (`version`);

--
-- Indexes for table `fngs_yoast_primary_term`
--
ALTER TABLE `fngs_yoast_primary_term`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_taxonomy` (`post_id`,`taxonomy`),
  ADD KEY `post_term` (`post_id`,`term_id`);

--
-- Indexes for table `fngs_yoast_seo_links`
--
ALTER TABLE `fngs_yoast_seo_links`
  ADD PRIMARY KEY (`id`),
  ADD KEY `link_direction` (`post_id`,`type`),
  ADD KEY `indexable_link_direction` (`indexable_id`,`type`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `fngs_actionscheduler_actions`
--
ALTER TABLE `fngs_actionscheduler_actions`
  MODIFY `action_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_actionscheduler_claims`
--
ALTER TABLE `fngs_actionscheduler_claims`
  MODIFY `claim_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_actionscheduler_groups`
--
ALTER TABLE `fngs_actionscheduler_groups`
  MODIFY `group_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_actionscheduler_logs`
--
ALTER TABLE `fngs_actionscheduler_logs`
  MODIFY `log_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_affiliate_wp_affiliatemeta`
--
ALTER TABLE `fngs_affiliate_wp_affiliatemeta`
  MODIFY `meta_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_affiliate_wp_affiliates`
--
ALTER TABLE `fngs_affiliate_wp_affiliates`
  MODIFY `affiliate_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_affiliate_wp_campaigns`
--
ALTER TABLE `fngs_affiliate_wp_campaigns`
  MODIFY `campaign_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_affiliate_wp_connections`
--
ALTER TABLE `fngs_affiliate_wp_connections`
  MODIFY `connection_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_affiliate_wp_coupons`
--
ALTER TABLE `fngs_affiliate_wp_coupons`
  MODIFY `coupon_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_affiliate_wp_creativemeta`
--
ALTER TABLE `fngs_affiliate_wp_creativemeta`
  MODIFY `meta_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_affiliate_wp_creatives`
--
ALTER TABLE `fngs_affiliate_wp_creatives`
  MODIFY `creative_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_affiliate_wp_customermeta`
--
ALTER TABLE `fngs_affiliate_wp_customermeta`
  MODIFY `meta_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_affiliate_wp_customers`
--
ALTER TABLE `fngs_affiliate_wp_customers`
  MODIFY `customer_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_affiliate_wp_custom_links`
--
ALTER TABLE `fngs_affiliate_wp_custom_links`
  MODIFY `custom_link_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_affiliate_wp_groups`
--
ALTER TABLE `fngs_affiliate_wp_groups`
  MODIFY `group_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_affiliate_wp_lifetime_customers`
--
ALTER TABLE `fngs_affiliate_wp_lifetime_customers`
  MODIFY `lifetime_customer_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_affiliate_wp_notifications`
--
ALTER TABLE `fngs_affiliate_wp_notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_affiliate_wp_payouts`
--
ALTER TABLE `fngs_affiliate_wp_payouts`
  MODIFY `payout_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_affiliate_wp_referralmeta`
--
ALTER TABLE `fngs_affiliate_wp_referralmeta`
  MODIFY `meta_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_affiliate_wp_referrals`
--
ALTER TABLE `fngs_affiliate_wp_referrals`
  MODIFY `referral_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_affiliate_wp_rest_consumers`
--
ALTER TABLE `fngs_affiliate_wp_rest_consumers`
  MODIFY `consumer_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_affiliate_wp_visits`
--
ALTER TABLE `fngs_affiliate_wp_visits`
  MODIFY `visit_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_aioseo_cache`
--
ALTER TABLE `fngs_aioseo_cache`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_aioseo_notifications`
--
ALTER TABLE `fngs_aioseo_notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_aioseo_posts`
--
ALTER TABLE `fngs_aioseo_posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bb_background_job_queue`
--
ALTER TABLE `fngs_bb_background_job_queue`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bb_background_process_logs`
--
ALTER TABLE `fngs_bb_background_process_logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bb_email_queue`
--
ALTER TABLE `fngs_bb_email_queue`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bb_notifications_subscriptions`
--
ALTER TABLE `fngs_bb_notifications_subscriptions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bb_polls`
--
ALTER TABLE `fngs_bb_polls`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bb_poll_options`
--
ALTER TABLE `fngs_bb_poll_options`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bb_poll_votes`
--
ALTER TABLE `fngs_bb_poll_votes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bb_reactions_data`
--
ALTER TABLE `fngs_bb_reactions_data`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bb_social_sign_on_users`
--
ALTER TABLE `fngs_bb_social_sign_on_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bb_user_reactions`
--
ALTER TABLE `fngs_bb_user_reactions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bb_xprofile_visibility`
--
ALTER TABLE `fngs_bb_xprofile_visibility`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_activity`
--
ALTER TABLE `fngs_bp_activity`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_activity_meta`
--
ALTER TABLE `fngs_bp_activity_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_document`
--
ALTER TABLE `fngs_bp_document`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_document_folder`
--
ALTER TABLE `fngs_bp_document_folder`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_document_folder_meta`
--
ALTER TABLE `fngs_bp_document_folder_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_document_meta`
--
ALTER TABLE `fngs_bp_document_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_follow`
--
ALTER TABLE `fngs_bp_follow`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_friends`
--
ALTER TABLE `fngs_bp_friends`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_groups`
--
ALTER TABLE `fngs_bp_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_groups_groupmeta`
--
ALTER TABLE `fngs_bp_groups_groupmeta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_groups_membermeta`
--
ALTER TABLE `fngs_bp_groups_membermeta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_groups_members`
--
ALTER TABLE `fngs_bp_groups_members`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_invitations`
--
ALTER TABLE `fngs_bp_invitations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_invitations_invitemeta`
--
ALTER TABLE `fngs_bp_invitations_invitemeta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_media`
--
ALTER TABLE `fngs_bp_media`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_media_albums`
--
ALTER TABLE `fngs_bp_media_albums`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_messages_messages`
--
ALTER TABLE `fngs_bp_messages_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_messages_meta`
--
ALTER TABLE `fngs_bp_messages_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_messages_notices`
--
ALTER TABLE `fngs_bp_messages_notices`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_messages_recipients`
--
ALTER TABLE `fngs_bp_messages_recipients`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_moderation`
--
ALTER TABLE `fngs_bp_moderation`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_moderation_meta`
--
ALTER TABLE `fngs_bp_moderation_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_notifications`
--
ALTER TABLE `fngs_bp_notifications`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_notifications_meta`
--
ALTER TABLE `fngs_bp_notifications_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_optouts`
--
ALTER TABLE `fngs_bp_optouts`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_suspend`
--
ALTER TABLE `fngs_bp_suspend`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_suspend_details`
--
ALTER TABLE `fngs_bp_suspend_details`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_suspend_meta`
--
ALTER TABLE `fngs_bp_suspend_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_xprofile_data`
--
ALTER TABLE `fngs_bp_xprofile_data`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_xprofile_fields`
--
ALTER TABLE `fngs_bp_xprofile_fields`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_xprofile_groups`
--
ALTER TABLE `fngs_bp_xprofile_groups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_xprofile_meta`
--
ALTER TABLE `fngs_bp_xprofile_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_zoom_meetings`
--
ALTER TABLE `fngs_bp_zoom_meetings`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_zoom_meeting_meta`
--
ALTER TABLE `fngs_bp_zoom_meeting_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_zoom_recordings`
--
ALTER TABLE `fngs_bp_zoom_recordings`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_zoom_webinars`
--
ALTER TABLE `fngs_bp_zoom_webinars`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_zoom_webinar_meta`
--
ALTER TABLE `fngs_bp_zoom_webinar_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_bp_zoom_webinar_recordings`
--
ALTER TABLE `fngs_bp_zoom_webinar_recordings`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_commentmeta`
--
ALTER TABLE `fngs_commentmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_comments`
--
ALTER TABLE `fngs_comments`
  MODIFY `comment_ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_e_events`
--
ALTER TABLE `fngs_e_events`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_e_notes`
--
ALTER TABLE `fngs_e_notes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_e_notes_users_relations`
--
ALTER TABLE `fngs_e_notes_users_relations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_e_submissions`
--
ALTER TABLE `fngs_e_submissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_e_submissions_actions_log`
--
ALTER TABLE `fngs_e_submissions_actions_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_e_submissions_values`
--
ALTER TABLE `fngs_e_submissions_values`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_facetwp_index`
--
ALTER TABLE `fngs_facetwp_index`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_gf_addon_feed`
--
ALTER TABLE `fngs_gf_addon_feed`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_gf_addon_payment_transaction`
--
ALTER TABLE `fngs_gf_addon_payment_transaction`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_gf_entry`
--
ALTER TABLE `fngs_gf_entry`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_gf_entry_meta`
--
ALTER TABLE `fngs_gf_entry_meta`
  MODIFY `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_gf_entry_notes`
--
ALTER TABLE `fngs_gf_entry_notes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_gf_form`
--
ALTER TABLE `fngs_gf_form`
  MODIFY `id` mediumint(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_gf_form_revisions`
--
ALTER TABLE `fngs_gf_form_revisions`
  MODIFY `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_gf_form_view`
--
ALTER TABLE `fngs_gf_form_view`
  MODIFY `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_gf_rest_api_keys`
--
ALTER TABLE `fngs_gf_rest_api_keys`
  MODIFY `key_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_links`
--
ALTER TABLE `fngs_links`
  MODIFY `link_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_options`
--
ALTER TABLE `fngs_options`
  MODIFY `option_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_pmxi_files`
--
ALTER TABLE `fngs_pmxi_files`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_pmxi_geocoding`
--
ALTER TABLE `fngs_pmxi_geocoding`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_pmxi_history`
--
ALTER TABLE `fngs_pmxi_history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_pmxi_images`
--
ALTER TABLE `fngs_pmxi_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_pmxi_imports`
--
ALTER TABLE `fngs_pmxi_imports`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_pmxi_posts`
--
ALTER TABLE `fngs_pmxi_posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_pmxi_templates`
--
ALTER TABLE `fngs_pmxi_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_postmeta`
--
ALTER TABLE `fngs_postmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_posts`
--
ALTER TABLE `fngs_posts`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_post_smtp_logmeta`
--
ALTER TABLE `fngs_post_smtp_logmeta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_post_smtp_logs`
--
ALTER TABLE `fngs_post_smtp_logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_pronamic_pay_mollie_customers`
--
ALTER TABLE `fngs_pronamic_pay_mollie_customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_pronamic_pay_mollie_customer_users`
--
ALTER TABLE `fngs_pronamic_pay_mollie_customer_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_pronamic_pay_mollie_organizations`
--
ALTER TABLE `fngs_pronamic_pay_mollie_organizations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_pronamic_pay_mollie_profiles`
--
ALTER TABLE `fngs_pronamic_pay_mollie_profiles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_rtwapwcm_mlm`
--
ALTER TABLE `fngs_rtwapwcm_mlm`
  MODIFY `id` mediumint(9) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_rtwapwcm_referrals`
--
ALTER TABLE `fngs_rtwapwcm_referrals`
  MODIFY `id` mediumint(9) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_rtwapwcm_referral_link`
--
ALTER TABLE `fngs_rtwapwcm_referral_link`
  MODIFY `id` mediumint(9) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_rtwapwcm_visitors_track`
--
ALTER TABLE `fngs_rtwapwcm_visitors_track`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_rtwapwcm_wallet_transaction`
--
ALTER TABLE `fngs_rtwapwcm_wallet_transaction`
  MODIFY `id` mediumint(9) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_signups`
--
ALTER TABLE `fngs_signups`
  MODIFY `signup_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_termmeta`
--
ALTER TABLE `fngs_termmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_terms`
--
ALTER TABLE `fngs_terms`
  MODIFY `term_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_term_taxonomy`
--
ALTER TABLE `fngs_term_taxonomy`
  MODIFY `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_uap_action_log`
--
ALTER TABLE `fngs_uap_action_log`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_uap_action_log_meta`
--
ALTER TABLE `fngs_uap_action_log_meta`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_uap_api_log`
--
ALTER TABLE `fngs_uap_api_log`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_uap_closure_log`
--
ALTER TABLE `fngs_uap_closure_log`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_uap_closure_log_meta`
--
ALTER TABLE `fngs_uap_closure_log_meta`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_uap_recipe_log`
--
ALTER TABLE `fngs_uap_recipe_log`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_uap_trigger_log`
--
ALTER TABLE `fngs_uap_trigger_log`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_uap_trigger_log_meta`
--
ALTER TABLE `fngs_uap_trigger_log_meta`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_usermeta`
--
ALTER TABLE `fngs_usermeta`
  MODIFY `umeta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_users`
--
ALTER TABLE `fngs_users`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_wc_admin_notes`
--
ALTER TABLE `fngs_wc_admin_notes`
  MODIFY `note_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_wc_admin_note_actions`
--
ALTER TABLE `fngs_wc_admin_note_actions`
  MODIFY `action_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_wc_customer_lookup`
--
ALTER TABLE `fngs_wc_customer_lookup`
  MODIFY `customer_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_wc_download_log`
--
ALTER TABLE `fngs_wc_download_log`
  MODIFY `download_log_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_wc_orders_meta`
--
ALTER TABLE `fngs_wc_orders_meta`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_wc_order_addresses`
--
ALTER TABLE `fngs_wc_order_addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_wc_order_operational_data`
--
ALTER TABLE `fngs_wc_order_operational_data`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_wc_product_download_directories`
--
ALTER TABLE `fngs_wc_product_download_directories`
  MODIFY `url_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_wc_rate_limits`
--
ALTER TABLE `fngs_wc_rate_limits`
  MODIFY `rate_limit_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_wc_tax_rate_classes`
--
ALTER TABLE `fngs_wc_tax_rate_classes`
  MODIFY `tax_rate_class_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_wc_webhooks`
--
ALTER TABLE `fngs_wc_webhooks`
  MODIFY `webhook_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_woocommerce_api_keys`
--
ALTER TABLE `fngs_woocommerce_api_keys`
  MODIFY `key_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_woocommerce_attribute_taxonomies`
--
ALTER TABLE `fngs_woocommerce_attribute_taxonomies`
  MODIFY `attribute_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_woocommerce_downloadable_product_permissions`
--
ALTER TABLE `fngs_woocommerce_downloadable_product_permissions`
  MODIFY `permission_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_woocommerce_log`
--
ALTER TABLE `fngs_woocommerce_log`
  MODIFY `log_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_woocommerce_order_itemmeta`
--
ALTER TABLE `fngs_woocommerce_order_itemmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_woocommerce_order_items`
--
ALTER TABLE `fngs_woocommerce_order_items`
  MODIFY `order_item_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_woocommerce_payment_tokenmeta`
--
ALTER TABLE `fngs_woocommerce_payment_tokenmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_woocommerce_payment_tokens`
--
ALTER TABLE `fngs_woocommerce_payment_tokens`
  MODIFY `token_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_woocommerce_sessions`
--
ALTER TABLE `fngs_woocommerce_sessions`
  MODIFY `session_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_woocommerce_shipping_zones`
--
ALTER TABLE `fngs_woocommerce_shipping_zones`
  MODIFY `zone_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_woocommerce_shipping_zone_locations`
--
ALTER TABLE `fngs_woocommerce_shipping_zone_locations`
  MODIFY `location_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_woocommerce_shipping_zone_methods`
--
ALTER TABLE `fngs_woocommerce_shipping_zone_methods`
  MODIFY `instance_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_woocommerce_tax_rates`
--
ALTER TABLE `fngs_woocommerce_tax_rates`
  MODIFY `tax_rate_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_woocommerce_tax_rate_locations`
--
ALTER TABLE `fngs_woocommerce_tax_rate_locations`
  MODIFY `location_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_wpmailsmtp_debug_events`
--
ALTER TABLE `fngs_wpmailsmtp_debug_events`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_wpmailsmtp_tasks_meta`
--
ALTER TABLE `fngs_wpmailsmtp_tasks_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_wpr_above_the_fold`
--
ALTER TABLE `fngs_wpr_above_the_fold`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_wpr_lazy_render_content`
--
ALTER TABLE `fngs_wpr_lazy_render_content`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_wpr_preconnect_external_domains`
--
ALTER TABLE `fngs_wpr_preconnect_external_domains`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_wpr_preload_fonts`
--
ALTER TABLE `fngs_wpr_preload_fonts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_wpr_rocket_cache`
--
ALTER TABLE `fngs_wpr_rocket_cache`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_wpr_rucss_used_css`
--
ALTER TABLE `fngs_wpr_rucss_used_css`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_wsal_metadata`
--
ALTER TABLE `fngs_wsal_metadata`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_wsal_occurrences`
--
ALTER TABLE `fngs_wsal_occurrences`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_yoast_indexable`
--
ALTER TABLE `fngs_yoast_indexable`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_yoast_migrations`
--
ALTER TABLE `fngs_yoast_migrations`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_yoast_primary_term`
--
ALTER TABLE `fngs_yoast_primary_term`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fngs_yoast_seo_links`
--
ALTER TABLE `fngs_yoast_seo_links`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `fngs_pronamic_pay_mollie_customers`
--
ALTER TABLE `fngs_pronamic_pay_mollie_customers`
  ADD CONSTRAINT `fk_customer_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `fngs_pronamic_pay_mollie_organizations` (`id`),
  ADD CONSTRAINT `fk_customer_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `fngs_pronamic_pay_mollie_profiles` (`id`);

--
-- Constraints for table `fngs_pronamic_pay_mollie_customer_users`
--
ALTER TABLE `fngs_pronamic_pay_mollie_customer_users`
  ADD CONSTRAINT `fk_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `fngs_pronamic_pay_mollie_customers` (`id`);

--
-- Constraints for table `fngs_pronamic_pay_mollie_profiles`
--
ALTER TABLE `fngs_pronamic_pay_mollie_profiles`
  ADD CONSTRAINT `fk_profile_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `fngs_pronamic_pay_mollie_organizations` (`id`);
--
-- Database: `chili_tqeh1`
--
CREATE DATABASE IF NOT EXISTS `chili_tqeh1` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `chili_tqeh1`;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_actionscheduler_actions`
--

CREATE TABLE `hc2n_actionscheduler_actions` (
  `action_id` bigint(20) UNSIGNED NOT NULL,
  `hook` varchar(191) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `scheduled_date_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  `scheduled_date_local` datetime DEFAULT '0000-00-00 00:00:00',
  `args` varchar(191) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `schedule` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `group_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `attempts` int(11) NOT NULL DEFAULT 0,
  `last_attempt_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  `last_attempt_local` datetime DEFAULT '0000-00-00 00:00:00',
  `claim_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `extended_args` varchar(8000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `priority` tinyint(3) UNSIGNED NOT NULL DEFAULT 10
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_actionscheduler_claims`
--

CREATE TABLE `hc2n_actionscheduler_claims` (
  `claim_id` bigint(20) UNSIGNED NOT NULL,
  `date_created_gmt` datetime DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_actionscheduler_groups`
--

CREATE TABLE `hc2n_actionscheduler_groups` (
  `group_id` bigint(20) UNSIGNED NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_actionscheduler_logs`
--

CREATE TABLE `hc2n_actionscheduler_logs` (
  `log_id` bigint(20) UNSIGNED NOT NULL,
  `action_id` bigint(20) UNSIGNED NOT NULL,
  `message` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `log_date_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  `log_date_local` datetime DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_affiliate_wp_affiliatemeta`
--

CREATE TABLE `hc2n_affiliate_wp_affiliatemeta` (
  `meta_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL DEFAULT 0,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_affiliate_wp_affiliates`
--

CREATE TABLE `hc2n_affiliate_wp_affiliates` (
  `affiliate_id` bigint(20) NOT NULL,
  `rest_id` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `rate` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate_type` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `flat_rate_basis` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_email` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `earnings` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `unpaid_earnings` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `referrals` bigint(20) NOT NULL,
  `visits` bigint(20) NOT NULL,
  `date_registered` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_affiliate_wp_campaigns`
--

CREATE TABLE `hc2n_affiliate_wp_campaigns` (
  `campaign_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL,
  `campaign` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `visits` bigint(20) NOT NULL,
  `unique_visits` bigint(20) NOT NULL,
  `referrals` bigint(20) NOT NULL,
  `conversion_rate` float NOT NULL,
  `hash` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rest_id` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_affiliate_wp_connections`
--

CREATE TABLE `hc2n_affiliate_wp_connections` (
  `connection_id` bigint(20) NOT NULL,
  `date` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `group` bigint(20) DEFAULT NULL,
  `creative` bigint(20) DEFAULT NULL,
  `affiliate` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_affiliate_wp_coupons`
--

CREATE TABLE `hc2n_affiliate_wp_coupons` (
  `coupon_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL,
  `coupon_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `locked` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_affiliate_wp_creativemeta`
--

CREATE TABLE `hc2n_affiliate_wp_creativemeta` (
  `meta_id` bigint(20) NOT NULL,
  `creative_id` bigint(20) NOT NULL DEFAULT 0,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_affiliate_wp_creatives`
--

CREATE TABLE `hc2n_affiliate_wp_creatives` (
  `creative_id` bigint(20) NOT NULL,
  `name` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `text` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachment_id` bigint(20) NOT NULL,
  `status` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  `date_updated` datetime NOT NULL DEFAULT current_timestamp(),
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `notes` longtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_affiliate_wp_customermeta`
--

CREATE TABLE `hc2n_affiliate_wp_customermeta` (
  `meta_id` bigint(20) NOT NULL,
  `affwp_customer_id` bigint(20) NOT NULL DEFAULT 0,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_affiliate_wp_customers`
--

CREATE TABLE `hc2n_affiliate_wp_customers` (
  `customer_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_affiliate_wp_custom_links`
--

CREATE TABLE `hc2n_affiliate_wp_custom_links` (
  `custom_link_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL,
  `link` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `campaign` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_affiliate_wp_groups`
--

CREATE TABLE `hc2n_affiliate_wp_groups` (
  `group_id` bigint(20) NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta` longtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_affiliate_wp_lifetime_customers`
--

CREATE TABLE `hc2n_affiliate_wp_lifetime_customers` (
  `lifetime_customer_id` bigint(20) NOT NULL,
  `affwp_customer_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_affiliate_wp_notifications`
--

CREATE TABLE `hc2n_affiliate_wp_notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `remote_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `buttons` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `type` varchar(64) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `conditions` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `dismissed` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_affiliate_wp_payouts`
--

CREATE TABLE `hc2n_affiliate_wp_payouts` (
  `payout_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL,
  `referrals` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` bigint(20) NOT NULL,
  `payout_method` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_account` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_id` bigint(20) NOT NULL,
  `service_invoice_link` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_affiliate_wp_referralmeta`
--

CREATE TABLE `hc2n_affiliate_wp_referralmeta` (
  `meta_id` bigint(20) NOT NULL,
  `referral_id` bigint(20) NOT NULL DEFAULT 0,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_affiliate_wp_referrals`
--

CREATE TABLE `hc2n_affiliate_wp_referrals` (
  `referral_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL,
  `visit_id` bigint(20) NOT NULL,
  `rest_id` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `parent_id` bigint(20) NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency` char(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `custom` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `context` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `campaign` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `flag` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `products` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `payout_id` bigint(20) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_affiliate_wp_rest_consumers`
--

CREATE TABLE `hc2n_affiliate_wp_rest_consumers` (
  `consumer_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `token` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `public_key` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret_key` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_affiliate_wp_sales`
--

CREATE TABLE `hc2n_affiliate_wp_sales` (
  `referral_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL,
  `order_total` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_affiliate_wp_visits`
--

CREATE TABLE `hc2n_affiliate_wp_visits` (
  `visit_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL,
  `referral_id` bigint(20) NOT NULL,
  `rest_id` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `referrer` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `campaign` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `context` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `flag` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_aioseo_cache`
--

CREATE TABLE `hc2n_aioseo_cache` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(80) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `expiration` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_aioseo_notifications`
--

CREATE TABLE `hc2n_aioseo_notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `slug` varchar(13) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `addon` varchar(64) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `type` varchar(64) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `level` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `notification_id` bigint(20) UNSIGNED DEFAULT NULL,
  `notification_name` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `button1_label` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `button1_action` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `button2_label` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `button2_action` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `dismissed` tinyint(1) NOT NULL DEFAULT 0,
  `new` tinyint(1) NOT NULL DEFAULT 1,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_aioseo_posts`
--

CREATE TABLE `hc2n_aioseo_posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `keywords` mediumtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `keyphrases` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `page_analysis` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `canonical_url` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_description` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_object_type` varchar(64) COLLATE utf8mb4_unicode_520_ci DEFAULT 'default',
  `og_image_type` varchar(64) COLLATE utf8mb4_unicode_520_ci DEFAULT 'default',
  `og_image_url` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_image_width` int(11) DEFAULT NULL,
  `og_image_height` int(11) DEFAULT NULL,
  `og_image_custom_url` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_image_custom_fields` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_video` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_custom_url` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_article_section` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_article_tags` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_use_og` tinyint(1) DEFAULT 0,
  `twitter_card` varchar(64) COLLATE utf8mb4_unicode_520_ci DEFAULT 'default',
  `twitter_image_type` varchar(64) COLLATE utf8mb4_unicode_520_ci DEFAULT 'default',
  `twitter_image_url` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_image_custom_url` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_image_custom_fields` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_description` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `seo_score` int(11) NOT NULL DEFAULT 0,
  `schema` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `schema_type` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT 'default',
  `schema_type_options` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `pillar_content` tinyint(1) DEFAULT NULL,
  `robots_default` tinyint(1) NOT NULL DEFAULT 1,
  `robots_noindex` tinyint(1) NOT NULL DEFAULT 0,
  `robots_noarchive` tinyint(1) NOT NULL DEFAULT 0,
  `robots_nosnippet` tinyint(1) NOT NULL DEFAULT 0,
  `robots_nofollow` tinyint(1) NOT NULL DEFAULT 0,
  `robots_noimageindex` tinyint(1) NOT NULL DEFAULT 0,
  `robots_noodp` tinyint(1) NOT NULL DEFAULT 0,
  `robots_notranslate` tinyint(1) NOT NULL DEFAULT 0,
  `robots_max_snippet` int(11) DEFAULT NULL,
  `robots_max_videopreview` int(11) DEFAULT NULL,
  `robots_max_imagepreview` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT 'large',
  `images` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `image_scan_date` datetime DEFAULT NULL,
  `priority` tinytext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `frequency` tinytext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `videos` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `video_thumbnail` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `video_scan_date` datetime DEFAULT NULL,
  `local_seo` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `limit_modified_date` tinyint(1) NOT NULL DEFAULT 0,
  `options` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bb_background_job_queue`
--

CREATE TABLE `hc2n_bb_background_job_queue` (
  `id` bigint(20) NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `group` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `data_id` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `secondary_data_id` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `data` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `priority` tinyint(2) DEFAULT NULL,
  `blog_id` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bb_background_process_logs`
--

CREATE TABLE `hc2n_bb_background_process_logs` (
  `id` bigint(20) NOT NULL,
  `process_id` bigint(20) NOT NULL,
  `parent` bigint(20) DEFAULT NULL,
  `component` varchar(55) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `bg_process_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `bg_process_from` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `callback_function` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `blog_id` bigint(20) NOT NULL,
  `data` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `priority` bigint(10) DEFAULT NULL,
  `memory` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT '0',
  `process_start_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `process_start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `process_end_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `process_end_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bb_email_queue`
--

CREATE TABLE `hc2n_bb_email_queue` (
  `id` bigint(20) NOT NULL,
  `email_type` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `recipient` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `arguments` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `scheduled` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bb_notifications_subscriptions`
--

CREATE TABLE `hc2n_bb_notifications_subscriptions` (
  `id` bigint(20) NOT NULL,
  `blog_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `secondary_item_id` bigint(20) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `date_recorded` datetime DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bb_polls`
--

CREATE TABLE `hc2n_bb_polls` (
  `id` bigint(20) NOT NULL,
  `item_id` bigint(20) DEFAULT 0,
  `item_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `secondary_item_id` bigint(20) DEFAULT 0,
  `user_id` bigint(20) NOT NULL,
  `question` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `settings` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `date_recorded` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `vote_disabled_date` datetime DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'draft'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bb_poll_options`
--

CREATE TABLE `hc2n_bb_poll_options` (
  `id` bigint(20) NOT NULL,
  `poll_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `option_title` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `option_order` bigint(2) DEFAULT NULL,
  `date_recorded` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bb_poll_votes`
--

CREATE TABLE `hc2n_bb_poll_votes` (
  `id` bigint(20) NOT NULL,
  `poll_id` bigint(20) NOT NULL,
  `option_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `date_recorded` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bb_reactions_data`
--

CREATE TABLE `hc2n_bb_reactions_data` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `rel1` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `rel2` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `rel3` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bb_social_sign_on_users`
--

CREATE TABLE `hc2n_bb_social_sign_on_users` (
  `id` int(11) NOT NULL,
  `wp_user_id` int(11) NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `identifier` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `register_date` datetime DEFAULT NULL,
  `login_date` datetime DEFAULT NULL,
  `link_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bb_user_reactions`
--

CREATE TABLE `hc2n_bb_user_reactions` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `reaction_id` bigint(20) NOT NULL,
  `item_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bb_xprofile_visibility`
--

CREATE TABLE `hc2n_bb_xprofile_visibility` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `field_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `value` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `last_updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_activity`
--

CREATE TABLE `hc2n_bp_activity` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `component` varchar(75) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `type` varchar(75) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `action` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `primary_link` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `secondary_item_id` bigint(20) DEFAULT NULL,
  `date_recorded` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `hide_sitewide` tinyint(1) DEFAULT 0,
  `mptt_left` int(11) NOT NULL DEFAULT 0,
  `mptt_right` int(11) NOT NULL DEFAULT 0,
  `is_spam` tinyint(1) NOT NULL DEFAULT 0,
  `privacy` varchar(75) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'public',
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'published'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_activity_meta`
--

CREATE TABLE `hc2n_bp_activity_meta` (
  `id` bigint(20) NOT NULL,
  `activity_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_document`
--

CREATE TABLE `hc2n_bp_document` (
  `id` bigint(20) NOT NULL,
  `blog_id` bigint(20) DEFAULT NULL,
  `attachment_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `folder_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `activity_id` bigint(20) DEFAULT NULL,
  `message_id` bigint(20) DEFAULT 0,
  `privacy` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT 'public',
  `menu_order` bigint(20) DEFAULT 0,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'published',
  `date_created` datetime DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_document_folder`
--

CREATE TABLE `hc2n_bp_document_folder` (
  `id` bigint(20) NOT NULL,
  `blog_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `parent` bigint(20) DEFAULT 0,
  `title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `privacy` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT 'public',
  `date_created` datetime DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_document_folder_meta`
--

CREATE TABLE `hc2n_bp_document_folder_meta` (
  `id` bigint(20) NOT NULL,
  `folder_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_document_meta`
--

CREATE TABLE `hc2n_bp_document_meta` (
  `id` bigint(20) NOT NULL,
  `document_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_follow`
--

CREATE TABLE `hc2n_bp_follow` (
  `id` bigint(20) NOT NULL,
  `leader_id` bigint(20) NOT NULL,
  `follower_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_friends`
--

CREATE TABLE `hc2n_bp_friends` (
  `id` bigint(20) NOT NULL,
  `initiator_user_id` bigint(20) NOT NULL,
  `friend_user_id` bigint(20) NOT NULL,
  `is_confirmed` tinyint(1) DEFAULT 0,
  `is_limited` tinyint(1) DEFAULT 0,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_groups`
--

CREATE TABLE `hc2n_bp_groups` (
  `id` bigint(20) NOT NULL,
  `creator_id` bigint(20) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `slug` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `status` varchar(10) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'public',
  `parent_id` bigint(20) NOT NULL DEFAULT 0,
  `enable_forum` tinyint(1) NOT NULL DEFAULT 1,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_groups_groupmeta`
--

CREATE TABLE `hc2n_bp_groups_groupmeta` (
  `id` bigint(20) NOT NULL,
  `group_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_groups_membermeta`
--

CREATE TABLE `hc2n_bp_groups_membermeta` (
  `id` bigint(20) NOT NULL,
  `member_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_groups_members`
--

CREATE TABLE `hc2n_bp_groups_members` (
  `id` bigint(20) NOT NULL,
  `group_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `inviter_id` bigint(20) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `is_mod` tinyint(1) NOT NULL DEFAULT 0,
  `user_title` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_modified` datetime NOT NULL,
  `comments` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `is_confirmed` tinyint(1) NOT NULL DEFAULT 0,
  `is_banned` tinyint(1) NOT NULL DEFAULT 0,
  `invite_sent` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_invitations`
--

CREATE TABLE `hc2n_bp_invitations` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `inviter_id` bigint(20) NOT NULL,
  `invitee_email` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `class` varchar(120) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `secondary_item_id` bigint(20) DEFAULT NULL,
  `type` varchar(12) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'invite',
  `content` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `date_modified` datetime NOT NULL,
  `invite_sent` tinyint(1) NOT NULL DEFAULT 0,
  `accepted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_invitations_invitemeta`
--

CREATE TABLE `hc2n_bp_invitations_invitemeta` (
  `id` bigint(20) NOT NULL,
  `invite_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_media`
--

CREATE TABLE `hc2n_bp_media` (
  `id` bigint(20) NOT NULL,
  `blog_id` bigint(20) DEFAULT NULL,
  `attachment_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `album_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `activity_id` bigint(20) DEFAULT NULL,
  `message_id` bigint(20) DEFAULT 0,
  `privacy` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT 'public',
  `type` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT 'photo',
  `menu_order` bigint(20) DEFAULT 0,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'published',
  `date_created` datetime DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_media_albums`
--

CREATE TABLE `hc2n_bp_media_albums` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT '0000-00-00 00:00:00',
  `title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `privacy` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT 'public'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_messages_messages`
--

CREATE TABLE `hc2n_bp_messages_messages` (
  `id` bigint(20) NOT NULL,
  `thread_id` bigint(20) NOT NULL,
  `sender_id` bigint(20) NOT NULL,
  `subject` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_sent` datetime NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_messages_meta`
--

CREATE TABLE `hc2n_bp_messages_meta` (
  `id` bigint(20) NOT NULL,
  `message_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_messages_notices`
--

CREATE TABLE `hc2n_bp_messages_notices` (
  `id` bigint(20) NOT NULL,
  `subject` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_sent` datetime NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_messages_recipients`
--

CREATE TABLE `hc2n_bp_messages_recipients` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `thread_id` bigint(20) NOT NULL,
  `unread_count` int(10) NOT NULL DEFAULT 0,
  `sender_only` tinyint(1) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  `is_hidden` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_moderation`
--

CREATE TABLE `hc2n_bp_moderation` (
  `id` bigint(20) NOT NULL,
  `moderation_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_created` datetime DEFAULT '0000-00-00 00:00:00',
  `category_id` bigint(20) NOT NULL,
  `user_report` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_moderation_meta`
--

CREATE TABLE `hc2n_bp_moderation_meta` (
  `id` bigint(20) NOT NULL,
  `moderation_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_notifications`
--

CREATE TABLE `hc2n_bp_notifications` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `secondary_item_id` bigint(20) DEFAULT NULL,
  `component_name` varchar(75) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `component_action` varchar(75) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_notified` datetime NOT NULL,
  `is_new` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_notifications_meta`
--

CREATE TABLE `hc2n_bp_notifications_meta` (
  `id` bigint(20) NOT NULL,
  `notification_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_optouts`
--

CREATE TABLE `hc2n_bp_optouts` (
  `id` bigint(20) NOT NULL,
  `email_address_hash` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `email_type` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_suspend`
--

CREATE TABLE `hc2n_bp_suspend` (
  `id` bigint(20) NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `item_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `hide_sitewide` tinyint(1) NOT NULL,
  `hide_parent` tinyint(1) NOT NULL,
  `user_suspended` tinyint(1) NOT NULL,
  `reported` tinyint(1) NOT NULL,
  `user_report` tinyint(4) DEFAULT 0,
  `last_updated` datetime DEFAULT '0000-00-00 00:00:00',
  `blog_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_suspend_details`
--

CREATE TABLE `hc2n_bp_suspend_details` (
  `id` bigint(20) NOT NULL,
  `suspend_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_suspend_meta`
--

CREATE TABLE `hc2n_bp_suspend_meta` (
  `id` bigint(20) NOT NULL,
  `suspend_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_xprofile_data`
--

CREATE TABLE `hc2n_bp_xprofile_data` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `field_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `last_updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_xprofile_fields`
--

CREATE TABLE `hc2n_bp_xprofile_fields` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `group_id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT 0,
  `is_default_option` tinyint(1) NOT NULL DEFAULT 0,
  `field_order` bigint(20) NOT NULL DEFAULT 0,
  `option_order` bigint(20) NOT NULL DEFAULT 0,
  `order_by` varchar(15) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `can_delete` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_xprofile_groups`
--

CREATE TABLE `hc2n_bp_xprofile_groups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `group_order` bigint(20) NOT NULL DEFAULT 0,
  `can_delete` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_xprofile_meta`
--

CREATE TABLE `hc2n_bp_xprofile_meta` (
  `id` bigint(20) NOT NULL,
  `object_id` bigint(20) NOT NULL,
  `object_type` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_zoom_meetings`
--

CREATE TABLE `hc2n_bp_zoom_meetings` (
  `id` bigint(20) NOT NULL,
  `group_id` bigint(20) NOT NULL,
  `activity_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `host_id` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `type` int(10) NOT NULL DEFAULT 2,
  `title` varchar(300) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` varchar(800) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `start_date_utc` datetime NOT NULL,
  `timezone` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `password` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `duration` int(11) NOT NULL,
  `join_before_host` tinyint(1) DEFAULT 0,
  `host_video` tinyint(1) DEFAULT 0,
  `participants_video` tinyint(1) DEFAULT 0,
  `mute_participants` tinyint(1) DEFAULT 0,
  `waiting_room` tinyint(1) DEFAULT 0,
  `meeting_authentication` tinyint(1) DEFAULT 0,
  `recurring` tinyint(1) DEFAULT 0,
  `auto_recording` varchar(75) COLLATE utf8mb4_unicode_520_ci DEFAULT 'none',
  `alternative_host_ids` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meeting_id` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `hide_sitewide` tinyint(1) DEFAULT 0,
  `parent` varchar(150) COLLATE utf8mb4_unicode_520_ci DEFAULT '0',
  `zoom_type` varchar(150) COLLATE utf8mb4_unicode_520_ci DEFAULT 'meeting',
  `alert` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_zoom_meeting_meta`
--

CREATE TABLE `hc2n_bp_zoom_meeting_meta` (
  `id` bigint(20) NOT NULL,
  `meeting_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_zoom_recordings`
--

CREATE TABLE `hc2n_bp_zoom_recordings` (
  `id` bigint(20) NOT NULL,
  `recording_id` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `meeting_id` bigint(20) NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `details` varchar(800) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `file_type` varchar(800) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `password` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `start_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_zoom_webinars`
--

CREATE TABLE `hc2n_bp_zoom_webinars` (
  `id` bigint(20) NOT NULL,
  `group_id` bigint(20) NOT NULL,
  `activity_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `host_id` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `type` int(10) NOT NULL DEFAULT 2,
  `title` varchar(300) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` varchar(800) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `start_date_utc` datetime NOT NULL,
  `timezone` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `password` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `duration` int(11) NOT NULL,
  `host_video` tinyint(1) DEFAULT 0,
  `panelists_video` tinyint(1) DEFAULT 0,
  `meeting_authentication` tinyint(1) DEFAULT 0,
  `practice_session` tinyint(1) DEFAULT 0,
  `on_demand` tinyint(1) DEFAULT 0,
  `recurring` tinyint(1) DEFAULT 0,
  `auto_recording` varchar(75) COLLATE utf8mb4_unicode_520_ci DEFAULT 'none',
  `alternative_host_ids` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `webinar_id` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `hide_sitewide` tinyint(1) DEFAULT 0,
  `parent` varchar(150) COLLATE utf8mb4_unicode_520_ci DEFAULT '0',
  `zoom_type` varchar(150) COLLATE utf8mb4_unicode_520_ci DEFAULT 'webinar',
  `alert` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_zoom_webinar_meta`
--

CREATE TABLE `hc2n_bp_zoom_webinar_meta` (
  `id` bigint(20) NOT NULL,
  `webinar_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_bp_zoom_webinar_recordings`
--

CREATE TABLE `hc2n_bp_zoom_webinar_recordings` (
  `id` bigint(20) NOT NULL,
  `recording_id` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `webinar_id` bigint(20) NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `details` varchar(800) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `file_type` varchar(800) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `password` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `start_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_commentmeta`
--

CREATE TABLE `hc2n_commentmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `comment_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_comments`
--

CREATE TABLE `hc2n_comments` (
  `comment_ID` bigint(20) UNSIGNED NOT NULL,
  `comment_post_ID` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `comment_author` tinytext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_author_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_url` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_IP` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_karma` int(11) NOT NULL DEFAULT 0,
  `comment_approved` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '1',
  `comment_agent` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'comment',
  `comment_parent` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_e_events`
--

CREATE TABLE `hc2n_e_events` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `event_data` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_e_notes`
--

CREATE TABLE `hc2n_e_notes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `route_url` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'Clean url where the note was created.',
  `route_title` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `route_post_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'The post id of the route that the note was created on.',
  `post_id` bigint(20) UNSIGNED DEFAULT NULL,
  `element_id` varchar(60) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'The Elementor element ID the note is attached to.',
  `parent_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `author_id` bigint(20) UNSIGNED DEFAULT NULL,
  `author_display_name` varchar(250) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'Save the author name when the author was deleted.',
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'publish',
  `position` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'A JSON string that represents the position of the note inside the element in percentages. e.g. {x:10, y:15}',
  `content` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `is_resolved` tinyint(1) NOT NULL DEFAULT 0,
  `is_public` tinyint(1) NOT NULL DEFAULT 1,
  `last_activity_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_e_notes_users_relations`
--

CREATE TABLE `hc2n_e_notes_users_relations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL COMMENT 'The relation type between user and note (e.g mention, watch, read).',
  `note_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_e_submissions`
--

CREATE TABLE `hc2n_e_submissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(60) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `hash_id` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `main_meta_id` bigint(20) UNSIGNED NOT NULL COMMENT 'Id of main field. to represent the main meta field',
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `referer` varchar(500) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `referer_title` varchar(300) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `element_id` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `form_name` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `campaign_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_ip` varchar(46) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `actions_count` int(11) DEFAULT 0,
  `actions_succeeded_count` int(11) DEFAULT 0,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `meta` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `created_at_gmt` datetime NOT NULL,
  `updated_at_gmt` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_e_submissions_actions_log`
--

CREATE TABLE `hc2n_e_submissions_actions_log` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `submission_id` bigint(20) UNSIGNED NOT NULL,
  `action_name` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `action_label` varchar(60) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `log` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `created_at_gmt` datetime NOT NULL,
  `updated_at_gmt` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_e_submissions_values`
--

CREATE TABLE `hc2n_e_submissions_values` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `submission_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `key` varchar(60) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_facetwp_cache`
--

CREATE TABLE `hc2n_facetwp_cache` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `value` longtext DEFAULT NULL,
  `expire` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_facetwp_index`
--

CREATE TABLE `hc2n_facetwp_index` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` int(10) UNSIGNED DEFAULT NULL,
  `facet_name` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `facet_value` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `facet_display_value` varchar(200) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `term_id` int(10) UNSIGNED DEFAULT 0,
  `parent_id` int(10) UNSIGNED DEFAULT 0,
  `depth` int(10) UNSIGNED DEFAULT 0,
  `variation_id` int(10) UNSIGNED DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_gf_addon_feed`
--

CREATE TABLE `hc2n_gf_addon_feed` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `form_id` mediumint(8) UNSIGNED NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `feed_order` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `meta` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `addon_slug` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `event_type` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_gf_addon_payment_callback`
--

CREATE TABLE `hc2n_gf_addon_payment_callback` (
  `id` int(10) UNSIGNED NOT NULL,
  `lead_id` int(10) UNSIGNED NOT NULL,
  `addon_slug` varchar(250) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `callback_id` varchar(250) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `date_created` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_gf_addon_payment_transaction`
--

CREATE TABLE `hc2n_gf_addon_payment_transaction` (
  `id` int(10) UNSIGNED NOT NULL,
  `lead_id` int(10) UNSIGNED NOT NULL,
  `transaction_type` varchar(30) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `transaction_id` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `subscription_id` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `is_recurring` tinyint(1) NOT NULL DEFAULT 0,
  `amount` decimal(19,2) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_gf_draft_submissions`
--

CREATE TABLE `hc2n_gf_draft_submissions` (
  `uuid` char(32) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `form_id` mediumint(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `ip` varchar(45) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `source_url` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `submission` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_gf_entry`
--

CREATE TABLE `hc2n_gf_entry` (
  `id` int(10) UNSIGNED NOT NULL,
  `form_id` mediumint(10) UNSIGNED NOT NULL,
  `post_id` bigint(10) UNSIGNED DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime DEFAULT NULL,
  `is_starred` tinyint(10) NOT NULL DEFAULT 0,
  `is_read` tinyint(10) NOT NULL DEFAULT 0,
  `ip` varchar(45) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `source_url` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_agent` varchar(250) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `currency` varchar(5) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `payment_status` varchar(15) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `payment_amount` decimal(19,2) DEFAULT NULL,
  `payment_method` varchar(30) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `transaction_id` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `is_fulfilled` tinyint(10) DEFAULT NULL,
  `created_by` bigint(10) UNSIGNED DEFAULT NULL,
  `transaction_type` tinyint(10) DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'active',
  `source_id` bigint(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_gf_entry_meta`
--

CREATE TABLE `hc2n_gf_entry_meta` (
  `id` bigint(10) UNSIGNED NOT NULL,
  `form_id` mediumint(10) UNSIGNED NOT NULL DEFAULT 0,
  `entry_id` bigint(10) UNSIGNED NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `item_index` varchar(60) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_gf_entry_notes`
--

CREATE TABLE `hc2n_gf_entry_notes` (
  `id` int(10) UNSIGNED NOT NULL,
  `entry_id` int(10) UNSIGNED NOT NULL,
  `user_name` varchar(250) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `user_id` bigint(10) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `note_type` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `sub_type` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_gf_form`
--

CREATE TABLE `hc2n_gf_form` (
  `id` mediumint(10) UNSIGNED NOT NULL,
  `title` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime DEFAULT NULL,
  `is_active` tinyint(10) NOT NULL DEFAULT 1,
  `is_trash` tinyint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_gf_form_meta`
--

CREATE TABLE `hc2n_gf_form_meta` (
  `form_id` mediumint(10) UNSIGNED NOT NULL,
  `display_meta` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `entries_grid_meta` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `confirmations` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `notifications` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_gf_form_revisions`
--

CREATE TABLE `hc2n_gf_form_revisions` (
  `id` bigint(10) UNSIGNED NOT NULL,
  `form_id` mediumint(10) UNSIGNED NOT NULL,
  `display_meta` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_gf_form_view`
--

CREATE TABLE `hc2n_gf_form_view` (
  `id` bigint(10) UNSIGNED NOT NULL,
  `form_id` mediumint(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `ip` char(15) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `count` mediumint(10) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_gf_rest_api_keys`
--

CREATE TABLE `hc2n_gf_rest_api_keys` (
  `key_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `permissions` varchar(10) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `consumer_key` char(64) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `consumer_secret` char(43) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `nonces` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `truncated_key` char(7) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `last_access` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_links`
--

CREATE TABLE `hc2n_links` (
  `link_id` bigint(20) UNSIGNED NOT NULL,
  `link_url` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_image` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_target` varchar(25) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_description` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_visible` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'Y',
  `link_owner` bigint(20) UNSIGNED NOT NULL DEFAULT 1,
  `link_rating` int(11) NOT NULL DEFAULT 0,
  `link_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_notes` mediumtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `link_rss` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_options`
--

CREATE TABLE `hc2n_options` (
  `option_id` bigint(20) UNSIGNED NOT NULL,
  `option_name` varchar(191) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `option_value` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `autoload` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'yes'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_pmxi_files`
--

CREATE TABLE `hc2n_pmxi_files` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `import_id` bigint(20) UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `path` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `registered_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_pmxi_geocoding`
--

CREATE TABLE `hc2n_pmxi_geocoding` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `address` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `latitude` decimal(18,15) DEFAULT NULL,
  `longitude` decimal(18,15) DEFAULT NULL,
  `raw_data` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `provider` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'google_maps',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_pmxi_hash`
--

CREATE TABLE `hc2n_pmxi_hash` (
  `hash` binary(16) NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `import_id` smallint(5) UNSIGNED NOT NULL,
  `post_type` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_pmxi_history`
--

CREATE TABLE `hc2n_pmxi_history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `import_id` bigint(20) UNSIGNED NOT NULL,
  `type` enum('manual','processing','trigger','continue','cli','') COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `time_run` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `summary` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_pmxi_images`
--

CREATE TABLE `hc2n_pmxi_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `attachment_id` bigint(20) UNSIGNED NOT NULL,
  `image_url` text COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `image_filename` text COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_pmxi_imports`
--

CREATE TABLE `hc2n_pmxi_imports` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `parent_import_id` bigint(20) NOT NULL DEFAULT 0,
  `name` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `friendly_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `type` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `feed_type` enum('xml','csv','zip','gz','') COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `path` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `xpath` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `options` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `registered_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `root_element` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `processing` tinyint(1) NOT NULL DEFAULT 0,
  `executing` tinyint(1) NOT NULL DEFAULT 0,
  `triggered` tinyint(1) NOT NULL DEFAULT 0,
  `queue_chunk_number` bigint(20) NOT NULL DEFAULT 0,
  `first_import` timestamp NOT NULL DEFAULT current_timestamp(),
  `count` bigint(20) NOT NULL DEFAULT 0,
  `imported` bigint(20) NOT NULL DEFAULT 0,
  `created` bigint(20) NOT NULL DEFAULT 0,
  `updated` bigint(20) NOT NULL DEFAULT 0,
  `skipped` bigint(20) NOT NULL DEFAULT 0,
  `deleted` bigint(20) NOT NULL DEFAULT 0,
  `canceled` tinyint(1) NOT NULL DEFAULT 0,
  `canceled_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `failed` tinyint(1) NOT NULL DEFAULT 0,
  `failed_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `settings_update_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_activity` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `iteration` bigint(20) NOT NULL DEFAULT 0,
  `changed_missing` bigint(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_pmxi_posts`
--

CREATE TABLE `hc2n_pmxi_posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `import_id` bigint(20) UNSIGNED NOT NULL,
  `unique_key` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `product_key` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `iteration` bigint(20) NOT NULL DEFAULT 0,
  `specified` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_pmxi_templates`
--

CREATE TABLE `hc2n_pmxi_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `options` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `scheduled` varchar(64) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `is_keep_linebreaks` tinyint(1) NOT NULL DEFAULT 0,
  `is_leave_html` tinyint(1) NOT NULL DEFAULT 0,
  `fix_characters` tinyint(1) NOT NULL DEFAULT 0,
  `meta` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_postmeta`
--

CREATE TABLE `hc2n_postmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_posts`
--

CREATE TABLE `hc2n_posts` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `post_author` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_excerpt` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `post_password` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `post_name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `to_ping` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `pinged` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_parent` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `guid` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `menu_order` int(11) NOT NULL DEFAULT 0,
  `post_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_count` bigint(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_post_smtp_logmeta`
--

CREATE TABLE `hc2n_post_smtp_logmeta` (
  `id` bigint(20) NOT NULL,
  `log_id` bigint(20) NOT NULL,
  `meta_key` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_post_smtp_logs`
--

CREATE TABLE `hc2n_post_smtp_logs` (
  `id` bigint(20) NOT NULL,
  `solution` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `success` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `from_header` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `to_header` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `cc_header` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `bcc_header` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `reply_to_header` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `transport_uri` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `original_to` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `original_subject` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `original_message` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `original_headers` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `session_transcript` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `time` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_pronamic_pay_mollie_customers`
--

CREATE TABLE `hc2n_pronamic_pay_mollie_customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `mollie_id` varchar(16) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `organization_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_id` bigint(20) UNSIGNED DEFAULT NULL,
  `test_mode` tinyint(1) NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_pronamic_pay_mollie_customer_users`
--

CREATE TABLE `hc2n_pronamic_pay_mollie_customer_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_pronamic_pay_mollie_organizations`
--

CREATE TABLE `hc2n_pronamic_pay_mollie_organizations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `mollie_id` varchar(16) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `name` varchar(128) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_pronamic_pay_mollie_profiles`
--

CREATE TABLE `hc2n_pronamic_pay_mollie_profiles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `mollie_id` varchar(16) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `organization_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(128) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `api_key_test` varchar(35) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `api_key_live` varchar(35) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_redirection_404`
--

CREATE TABLE `hc2n_redirection_404` (
  `id` int(11) UNSIGNED NOT NULL,
  `created` datetime NOT NULL,
  `url` mediumtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `domain` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `agent` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `referrer` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `http_code` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `request_method` varchar(10) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `request_data` mediumtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `ip` varchar(45) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_redirection_groups`
--

CREATE TABLE `hc2n_redirection_groups` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `tracking` int(11) NOT NULL DEFAULT 1,
  `module_id` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `status` enum('enabled','disabled') COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'enabled',
  `position` int(11) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_redirection_items`
--

CREATE TABLE `hc2n_redirection_items` (
  `id` int(11) UNSIGNED NOT NULL,
  `url` mediumtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `match_url` varchar(2000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `match_data` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `regex` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `position` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `last_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `last_access` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `group_id` int(11) NOT NULL DEFAULT 0,
  `status` enum('enabled','disabled') COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'enabled',
  `action_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `action_code` int(11) UNSIGNED NOT NULL,
  `action_data` mediumtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `match_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_redirection_logs`
--

CREATE TABLE `hc2n_redirection_logs` (
  `id` int(11) UNSIGNED NOT NULL,
  `created` datetime NOT NULL,
  `url` mediumtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `domain` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `sent_to` mediumtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `agent` mediumtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `referrer` mediumtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `http_code` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `request_method` varchar(10) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `request_data` mediumtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `redirect_by` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `redirection_id` int(11) UNSIGNED DEFAULT NULL,
  `ip` varchar(45) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_rp4wp_cache`
--

CREATE TABLE `hc2n_rp4wp_cache` (
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `word` varchar(255) NOT NULL,
  `weight` float UNSIGNED NOT NULL,
  `post_type` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_rtwapwcm_mlm`
--

CREATE TABLE `hc2n_rtwapwcm_mlm` (
  `id` mediumint(9) NOT NULL,
  `aff_id` bigint(20) NOT NULL,
  `parent_id` bigint(20) NOT NULL,
  `level` int(11) NOT NULL DEFAULT 1,
  `level_active` int(11) NOT NULL DEFAULT 1,
  `level_comm` decimal(10,2) NOT NULL DEFAULT 0.00,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `last_activity` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `added_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_rtwapwcm_referrals`
--

CREATE TABLE `hc2n_rtwapwcm_referrals` (
  `id` mediumint(9) NOT NULL,
  `aff_id` bigint(20) NOT NULL,
  `type` tinyint(1) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `batch_id` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` tinyint(2) NOT NULL DEFAULT 0,
  `amount` decimal(12,2) NOT NULL,
  `capped` tinyint(1) NOT NULL DEFAULT 0,
  `currency` varchar(55) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `product_details` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `payment_type` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `device` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `ip` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `signed_up_id` int(10) NOT NULL,
  `payment_create_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `payment_update_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `message` varchar(150) COLLATE utf8mb4_unicode_520_ci DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_rtwapwcm_referral_link`
--

CREATE TABLE `hc2n_rtwapwcm_referral_link` (
  `id` mediumint(9) NOT NULL,
  `aff_id` bigint(20) NOT NULL,
  `aff_link` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `link_open` int(10) NOT NULL DEFAULT 0,
  `link_purchase` int(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_rtwapwcm_visitors_track`
--

CREATE TABLE `hc2n_rtwapwcm_visitors_track` (
  `id` int(6) NOT NULL,
  `aff_id` int(6) NOT NULL,
  `ref_link` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `agent` varchar(30) COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `device` varchar(10) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `platform` varchar(25) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `ip` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `count` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_rtwapwcm_wallet_transaction`
--

CREATE TABLE `hc2n_rtwapwcm_wallet_transaction` (
  `id` mediumint(9) NOT NULL,
  `aff_id` bigint(20) NOT NULL,
  `request_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `amount` decimal(12,2) NOT NULL,
  `pay_status` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `batch_id` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_signups`
--

CREATE TABLE `hc2n_signups` (
  `signup_id` bigint(20) NOT NULL,
  `domain` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `path` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `title` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_login` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `activated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT 0,
  `activation_key` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `meta` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_termmeta`
--

CREATE TABLE `hc2n_termmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_terms`
--

CREATE TABLE `hc2n_terms` (
  `term_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `slug` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `term_group` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_term_relationships`
--

CREATE TABLE `hc2n_term_relationships` (
  `object_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `term_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_term_taxonomy`
--

CREATE TABLE `hc2n_term_taxonomy` (
  `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `taxonomy` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `description` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `parent` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `count` bigint(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_uap_action_log`
--

CREATE TABLE `hc2n_uap_action_log` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `date_time` timestamp NULL DEFAULT current_timestamp(),
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `automator_action_id` bigint(20) UNSIGNED NOT NULL,
  `automator_recipe_id` bigint(20) UNSIGNED NOT NULL,
  `automator_recipe_log_id` bigint(20) UNSIGNED DEFAULT NULL,
  `completed` tinyint(1) UNSIGNED NOT NULL,
  `error_message` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_uap_action_log_meta`
--

CREATE TABLE `hc2n_uap_action_log_meta` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `automator_action_log_id` bigint(20) UNSIGNED DEFAULT NULL,
  `automator_action_id` bigint(20) UNSIGNED NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_uap_api_log`
--

CREATE TABLE `hc2n_uap_api_log` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `date_time` timestamp NULL DEFAULT current_timestamp(),
  `type` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `recipe_log_id` bigint(20) UNSIGNED NOT NULL,
  `item_log_id` bigint(20) UNSIGNED NOT NULL,
  `endpoint` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `params` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `request` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `response` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `price` bigint(20) UNSIGNED DEFAULT NULL,
  `balance` bigint(20) UNSIGNED DEFAULT NULL,
  `time_spent` bigint(20) UNSIGNED DEFAULT NULL,
  `notes` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_uap_closure_log`
--

CREATE TABLE `hc2n_uap_closure_log` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `date_time` timestamp NULL DEFAULT current_timestamp(),
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `automator_closure_id` bigint(20) UNSIGNED NOT NULL,
  `automator_recipe_id` bigint(20) UNSIGNED NOT NULL,
  `automator_recipe_log_id` bigint(20) UNSIGNED NOT NULL,
  `completed` tinyint(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_uap_closure_log_meta`
--

CREATE TABLE `hc2n_uap_closure_log_meta` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `automator_closure_id` bigint(20) UNSIGNED NOT NULL,
  `automator_closure_log_id` bigint(20) UNSIGNED NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_uap_recipe_log`
--

CREATE TABLE `hc2n_uap_recipe_log` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `date_time` timestamp NULL DEFAULT current_timestamp(),
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `automator_recipe_id` bigint(20) UNSIGNED NOT NULL,
  `completed` tinyint(1) NOT NULL,
  `run_number` mediumint(8) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_uap_trigger_log`
--

CREATE TABLE `hc2n_uap_trigger_log` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `date_time` timestamp NULL DEFAULT current_timestamp(),
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `automator_trigger_id` bigint(20) UNSIGNED NOT NULL,
  `automator_recipe_id` bigint(20) UNSIGNED NOT NULL,
  `automator_recipe_log_id` bigint(20) UNSIGNED DEFAULT NULL,
  `completed` tinyint(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_uap_trigger_log_meta`
--

CREATE TABLE `hc2n_uap_trigger_log_meta` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `automator_trigger_log_id` bigint(20) UNSIGNED DEFAULT NULL,
  `automator_trigger_id` bigint(20) UNSIGNED NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `run_number` mediumint(8) UNSIGNED NOT NULL DEFAULT 1,
  `run_time` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_umbrella_backup`
--

CREATE TABLE `hc2n_umbrella_backup` (
  `id` bigint(20) NOT NULL,
  `count_attachments` int(11) DEFAULT NULL,
  `count_public_posts` int(11) DEFAULT NULL,
  `count_plugins` int(11) DEFAULT NULL,
  `wp_core_version` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `config_database` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `config_file` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `title` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `suffix` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `is_scheduled` tinyint(4) DEFAULT NULL,
  `backupId` bigint(20) DEFAULT NULL,
  `incremental_date` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `status` varchar(128) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `finish_file` tinyint(4) DEFAULT NULL,
  `finish_database` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_umbrella_log`
--

CREATE TABLE `hc2n_umbrella_log` (
  `id` bigint(20) NOT NULL,
  `code` varchar(128) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `message` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `backupId` bigint(20) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_umbrella_task_backup`
--

CREATE TABLE `hc2n_umbrella_task_backup` (
  `id` bigint(20) NOT NULL,
  `date_schedule` datetime DEFAULT current_timestamp(),
  `date_start` datetime DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `jobId` bigint(20) DEFAULT NULL,
  `type` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `status` varchar(128) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `backupId` bigint(20) DEFAULT NULL,
  `log` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_usermeta`
--

CREATE TABLE `hc2n_usermeta` (
  `umeta_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_users`
--

CREATE TABLE `hc2n_users` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `user_login` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_pass` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_nicename` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_url` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_status` int(11) NOT NULL DEFAULT 0,
  `display_name` varchar(250) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wc_admin_notes`
--

CREATE TABLE `hc2n_wc_admin_notes` (
  `note_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `locale` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `title` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content_data` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `status` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `source` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_reminder` datetime DEFAULT NULL,
  `is_snoozable` tinyint(1) NOT NULL DEFAULT 0,
  `layout` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `image` varchar(200) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `icon` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'info'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wc_admin_note_actions`
--

CREATE TABLE `hc2n_wc_admin_note_actions` (
  `action_id` bigint(20) UNSIGNED NOT NULL,
  `note_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `query` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `actioned_text` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `nonce_action` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `nonce_name` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wc_category_lookup`
--

CREATE TABLE `hc2n_wc_category_lookup` (
  `category_tree_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wc_customer_lookup`
--

CREATE TABLE `hc2n_wc_customer_lookup` (
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `username` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `first_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `date_last_active` timestamp NULL DEFAULT NULL,
  `date_registered` timestamp NULL DEFAULT NULL,
  `country` char(2) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `postcode` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `city` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `state` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wc_download_log`
--

CREATE TABLE `hc2n_wc_download_log` (
  `download_log_id` bigint(20) UNSIGNED NOT NULL,
  `timestamp` datetime NOT NULL,
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_ip_address` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wc_orders`
--

CREATE TABLE `hc2n_wc_orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `currency` varchar(10) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `tax_amount` decimal(26,8) DEFAULT NULL,
  `total_amount` decimal(26,8) DEFAULT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `billing_email` varchar(320) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `date_created_gmt` datetime DEFAULT NULL,
  `date_updated_gmt` datetime DEFAULT NULL,
  `parent_order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payment_method` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `payment_method_title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `transaction_id` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `ip_address` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `customer_note` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wc_orders_meta`
--

CREATE TABLE `hc2n_wc_orders_meta` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wc_order_addresses`
--

CREATE TABLE `hc2n_wc_order_addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `address_type` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `first_name` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `last_name` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `company` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `address_1` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `address_2` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `city` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `state` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `postcode` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `country` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `email` varchar(320) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `phone` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wc_order_coupon_lookup`
--

CREATE TABLE `hc2n_wc_order_coupon_lookup` (
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `coupon_id` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `discount_amount` double NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wc_order_operational_data`
--

CREATE TABLE `hc2n_wc_order_operational_data` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_via` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `woocommerce_version` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `prices_include_tax` tinyint(1) DEFAULT NULL,
  `coupon_usages_are_counted` tinyint(1) DEFAULT NULL,
  `download_permission_granted` tinyint(1) DEFAULT NULL,
  `cart_hash` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `new_order_email_sent` tinyint(1) DEFAULT NULL,
  `order_key` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `order_stock_reduced` tinyint(1) DEFAULT NULL,
  `date_paid_gmt` datetime DEFAULT NULL,
  `date_completed_gmt` datetime DEFAULT NULL,
  `shipping_tax_amount` decimal(26,8) DEFAULT NULL,
  `shipping_total_amount` decimal(26,8) DEFAULT NULL,
  `discount_tax_amount` decimal(26,8) DEFAULT NULL,
  `discount_total_amount` decimal(26,8) DEFAULT NULL,
  `recorded_sales` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wc_order_product_lookup`
--

CREATE TABLE `hc2n_wc_order_product_lookup` (
  `order_item_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `variation_id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `product_qty` int(11) NOT NULL,
  `product_net_revenue` double NOT NULL DEFAULT 0,
  `product_gross_revenue` double NOT NULL DEFAULT 0,
  `coupon_amount` double NOT NULL DEFAULT 0,
  `tax_amount` double NOT NULL DEFAULT 0,
  `shipping_amount` double NOT NULL DEFAULT 0,
  `shipping_tax_amount` double NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wc_order_stats`
--

CREATE TABLE `hc2n_wc_order_stats` (
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_created_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_paid` datetime DEFAULT '0000-00-00 00:00:00',
  `date_completed` datetime DEFAULT '0000-00-00 00:00:00',
  `num_items_sold` int(11) NOT NULL DEFAULT 0,
  `total_sales` double NOT NULL DEFAULT 0,
  `tax_total` double NOT NULL DEFAULT 0,
  `shipping_total` double NOT NULL DEFAULT 0,
  `net_total` double NOT NULL DEFAULT 0,
  `returning_customer` tinyint(1) DEFAULT NULL,
  `status` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wc_order_tax_lookup`
--

CREATE TABLE `hc2n_wc_order_tax_lookup` (
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `tax_rate_id` bigint(20) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `shipping_tax` double NOT NULL DEFAULT 0,
  `order_tax` double NOT NULL DEFAULT 0,
  `total_tax` double NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wc_product_attributes_lookup`
--

CREATE TABLE `hc2n_wc_product_attributes_lookup` (
  `product_id` bigint(20) NOT NULL,
  `product_or_parent_id` bigint(20) NOT NULL,
  `taxonomy` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `term_id` bigint(20) NOT NULL,
  `is_variation_attribute` tinyint(1) NOT NULL,
  `in_stock` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wc_product_download_directories`
--

CREATE TABLE `hc2n_wc_product_download_directories` (
  `url_id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(256) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wc_product_meta_lookup`
--

CREATE TABLE `hc2n_wc_product_meta_lookup` (
  `product_id` bigint(20) NOT NULL,
  `sku` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `global_unique_id` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `virtual` tinyint(1) DEFAULT 0,
  `downloadable` tinyint(1) DEFAULT 0,
  `min_price` decimal(19,4) DEFAULT NULL,
  `max_price` decimal(19,4) DEFAULT NULL,
  `onsale` tinyint(1) DEFAULT 0,
  `stock_quantity` double DEFAULT NULL,
  `stock_status` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT 'instock',
  `rating_count` bigint(20) DEFAULT 0,
  `average_rating` decimal(3,2) DEFAULT 0.00,
  `total_sales` bigint(20) DEFAULT 0,
  `tax_status` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT 'taxable',
  `tax_class` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wc_rate_limits`
--

CREATE TABLE `hc2n_wc_rate_limits` (
  `rate_limit_id` bigint(20) UNSIGNED NOT NULL,
  `rate_limit_key` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `rate_limit_expiry` bigint(20) UNSIGNED NOT NULL,
  `rate_limit_remaining` smallint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wc_reserved_stock`
--

CREATE TABLE `hc2n_wc_reserved_stock` (
  `order_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `stock_quantity` double NOT NULL DEFAULT 0,
  `timestamp` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `expires` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wc_tax_rate_classes`
--

CREATE TABLE `hc2n_wc_tax_rate_classes` (
  `tax_rate_class_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `slug` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wc_webhooks`
--

CREATE TABLE `hc2n_wc_webhooks` (
  `webhook_id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `name` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `delivery_url` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `secret` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `topic` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_created_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `api_version` smallint(4) NOT NULL,
  `failure_count` smallint(10) NOT NULL DEFAULT 0,
  `pending_delivery` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wfauditevents`
--

CREATE TABLE `hc2n_wfauditevents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT '',
  `data` text NOT NULL,
  `event_time` double(14,4) NOT NULL,
  `request_id` bigint(20) UNSIGNED NOT NULL,
  `state` enum('new','sending','sent') NOT NULL DEFAULT 'new',
  `state_timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wfblockediplog`
--

CREATE TABLE `hc2n_wfblockediplog` (
  `IP` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `countryCode` varchar(2) NOT NULL,
  `blockCount` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `unixday` int(10) UNSIGNED NOT NULL,
  `blockType` varchar(50) NOT NULL DEFAULT 'generic'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wfblocks7`
--

CREATE TABLE `hc2n_wfblocks7` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `IP` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `blockedTime` bigint(20) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `lastAttempt` int(10) UNSIGNED DEFAULT 0,
  `blockedHits` int(10) UNSIGNED DEFAULT 0,
  `expiration` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `parameters` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wfconfig`
--

CREATE TABLE `hc2n_wfconfig` (
  `name` varchar(100) NOT NULL,
  `val` longblob DEFAULT NULL,
  `autoload` enum('no','yes') NOT NULL DEFAULT 'yes'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wfcrawlers`
--

CREATE TABLE `hc2n_wfcrawlers` (
  `IP` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `patternSig` binary(16) NOT NULL,
  `status` char(8) NOT NULL,
  `lastUpdate` int(10) UNSIGNED NOT NULL,
  `PTR` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wffilechanges`
--

CREATE TABLE `hc2n_wffilechanges` (
  `filenameHash` char(64) NOT NULL,
  `file` varchar(1000) NOT NULL,
  `md5` char(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wffilemods`
--

CREATE TABLE `hc2n_wffilemods` (
  `filenameMD5` binary(16) NOT NULL,
  `filename` varchar(1000) NOT NULL,
  `real_path` text NOT NULL,
  `knownFile` tinyint(3) UNSIGNED NOT NULL,
  `oldMD5` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `newMD5` binary(16) NOT NULL,
  `SHAC` binary(32) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `stoppedOnSignature` varchar(255) NOT NULL DEFAULT '',
  `stoppedOnPosition` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `isSafeFile` varchar(1) NOT NULL DEFAULT '?'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wfhits`
--

CREATE TABLE `hc2n_wfhits` (
  `id` int(10) UNSIGNED NOT NULL,
  `attackLogTime` double(17,6) UNSIGNED NOT NULL,
  `ctime` double(17,6) UNSIGNED NOT NULL,
  `IP` binary(16) DEFAULT NULL,
  `jsRun` tinyint(4) DEFAULT 0,
  `statusCode` int(11) NOT NULL DEFAULT 200,
  `isGoogle` tinyint(4) NOT NULL,
  `userID` int(10) UNSIGNED NOT NULL,
  `newVisit` tinyint(3) UNSIGNED NOT NULL,
  `URL` text DEFAULT NULL,
  `referer` text DEFAULT NULL,
  `UA` text DEFAULT NULL,
  `action` varchar(64) NOT NULL DEFAULT '',
  `actionDescription` text DEFAULT NULL,
  `actionData` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wfhoover`
--

CREATE TABLE `hc2n_wfhoover` (
  `id` int(10) UNSIGNED NOT NULL,
  `owner` text DEFAULT NULL,
  `host` text DEFAULT NULL,
  `path` text DEFAULT NULL,
  `hostKey` varbinary(124) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wfissues`
--

CREATE TABLE `hc2n_wfissues` (
  `id` int(10) UNSIGNED NOT NULL,
  `time` int(10) UNSIGNED NOT NULL,
  `lastUpdated` int(10) UNSIGNED NOT NULL,
  `status` varchar(10) NOT NULL,
  `type` varchar(20) NOT NULL,
  `severity` tinyint(3) UNSIGNED NOT NULL,
  `ignoreP` char(32) NOT NULL,
  `ignoreC` char(32) NOT NULL,
  `shortMsg` varchar(255) NOT NULL,
  `longMsg` text DEFAULT NULL,
  `data` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wfknownfilelist`
--

CREATE TABLE `hc2n_wfknownfilelist` (
  `id` int(11) UNSIGNED NOT NULL,
  `path` text NOT NULL,
  `wordpress_path` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wflivetraffichuman`
--

CREATE TABLE `hc2n_wflivetraffichuman` (
  `IP` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `identifier` binary(32) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `expiration` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wflocs`
--

CREATE TABLE `hc2n_wflocs` (
  `IP` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `ctime` int(10) UNSIGNED NOT NULL,
  `failed` tinyint(3) UNSIGNED NOT NULL,
  `city` varchar(255) DEFAULT '',
  `region` varchar(255) DEFAULT '',
  `countryName` varchar(255) DEFAULT '',
  `countryCode` char(2) DEFAULT '',
  `lat` float(10,7) DEFAULT 0.0000000,
  `lon` float(10,7) DEFAULT 0.0000000
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wflogins`
--

CREATE TABLE `hc2n_wflogins` (
  `id` int(10) UNSIGNED NOT NULL,
  `hitID` int(11) DEFAULT NULL,
  `ctime` double(17,6) UNSIGNED NOT NULL,
  `fail` tinyint(3) UNSIGNED NOT NULL,
  `action` varchar(40) NOT NULL,
  `username` varchar(255) NOT NULL,
  `userID` int(10) UNSIGNED NOT NULL,
  `IP` binary(16) DEFAULT NULL,
  `UA` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wfls_2fa_secrets`
--

CREATE TABLE `hc2n_wfls_2fa_secrets` (
  `id` int(11) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `secret` tinyblob NOT NULL,
  `recovery` blob NOT NULL,
  `ctime` int(10) UNSIGNED NOT NULL,
  `vtime` int(10) UNSIGNED NOT NULL,
  `mode` enum('authenticator') NOT NULL DEFAULT 'authenticator'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wfls_role_counts`
--

CREATE TABLE `hc2n_wfls_role_counts` (
  `serialized_roles` varbinary(255) NOT NULL,
  `two_factor_inactive` tinyint(1) NOT NULL,
  `user_count` bigint(20) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=MEMORY DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wfls_settings`
--

CREATE TABLE `hc2n_wfls_settings` (
  `name` varchar(191) NOT NULL DEFAULT '',
  `value` longblob DEFAULT NULL,
  `autoload` enum('no','yes') NOT NULL DEFAULT 'yes'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wfnotifications`
--

CREATE TABLE `hc2n_wfnotifications` (
  `id` varchar(32) NOT NULL DEFAULT '',
  `new` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `category` varchar(255) NOT NULL,
  `priority` int(11) NOT NULL DEFAULT 1000,
  `ctime` int(10) UNSIGNED NOT NULL,
  `html` text NOT NULL,
  `links` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wfpendingissues`
--

CREATE TABLE `hc2n_wfpendingissues` (
  `id` int(10) UNSIGNED NOT NULL,
  `time` int(10) UNSIGNED NOT NULL,
  `lastUpdated` int(10) UNSIGNED NOT NULL,
  `status` varchar(10) NOT NULL,
  `type` varchar(20) NOT NULL,
  `severity` tinyint(3) UNSIGNED NOT NULL,
  `ignoreP` char(32) NOT NULL,
  `ignoreC` char(32) NOT NULL,
  `shortMsg` varchar(255) NOT NULL,
  `longMsg` text DEFAULT NULL,
  `data` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wfreversecache`
--

CREATE TABLE `hc2n_wfreversecache` (
  `IP` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `host` varchar(255) NOT NULL,
  `lastUpdate` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wfsecurityevents`
--

CREATE TABLE `hc2n_wfsecurityevents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT '',
  `data` text NOT NULL,
  `event_time` double(14,4) NOT NULL,
  `state` enum('new','sending','sent') NOT NULL DEFAULT 'new',
  `state_timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wfsnipcache`
--

CREATE TABLE `hc2n_wfsnipcache` (
  `id` int(10) UNSIGNED NOT NULL,
  `IP` varchar(45) NOT NULL DEFAULT '',
  `expiration` timestamp NOT NULL DEFAULT current_timestamp(),
  `body` varchar(255) NOT NULL DEFAULT '',
  `count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `type` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wfstatus`
--

CREATE TABLE `hc2n_wfstatus` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ctime` double(17,6) UNSIGNED NOT NULL,
  `level` tinyint(3) UNSIGNED NOT NULL,
  `type` char(5) NOT NULL,
  `msg` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wftrafficrates`
--

CREATE TABLE `hc2n_wftrafficrates` (
  `eMin` int(10) UNSIGNED NOT NULL,
  `IP` binary(16) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `hitType` enum('hit','404') NOT NULL DEFAULT 'hit',
  `hits` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wfwaffailures`
--

CREATE TABLE `hc2n_wfwaffailures` (
  `id` int(10) UNSIGNED NOT NULL,
  `throwable` text NOT NULL,
  `rule_id` int(10) UNSIGNED DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_woocommerce_api_keys`
--

CREATE TABLE `hc2n_woocommerce_api_keys` (
  `key_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `permissions` varchar(10) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `consumer_key` char(64) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `consumer_secret` char(43) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `nonces` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `truncated_key` char(7) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `last_access` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_woocommerce_attribute_taxonomies`
--

CREATE TABLE `hc2n_woocommerce_attribute_taxonomies` (
  `attribute_id` bigint(20) UNSIGNED NOT NULL,
  `attribute_name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `attribute_label` varchar(200) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `attribute_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `attribute_orderby` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `attribute_public` int(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_woocommerce_downloadable_product_permissions`
--

CREATE TABLE `hc2n_woocommerce_downloadable_product_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `download_id` varchar(36) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `order_key` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_email` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `downloads_remaining` varchar(9) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `access_granted` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `access_expires` datetime DEFAULT NULL,
  `download_count` bigint(20) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_woocommerce_log`
--

CREATE TABLE `hc2n_woocommerce_log` (
  `log_id` bigint(20) UNSIGNED NOT NULL,
  `timestamp` datetime NOT NULL,
  `level` smallint(4) NOT NULL,
  `source` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `context` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_woocommerce_order_itemmeta`
--

CREATE TABLE `hc2n_woocommerce_order_itemmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `order_item_id` bigint(20) UNSIGNED NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_woocommerce_order_items`
--

CREATE TABLE `hc2n_woocommerce_order_items` (
  `order_item_id` bigint(20) UNSIGNED NOT NULL,
  `order_item_name` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `order_item_type` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `order_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_woocommerce_payment_tokenmeta`
--

CREATE TABLE `hc2n_woocommerce_payment_tokenmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `payment_token_id` bigint(20) UNSIGNED NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_woocommerce_payment_tokens`
--

CREATE TABLE `hc2n_woocommerce_payment_tokens` (
  `token_id` bigint(20) UNSIGNED NOT NULL,
  `gateway_id` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `token` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `type` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_woocommerce_sessions`
--

CREATE TABLE `hc2n_woocommerce_sessions` (
  `session_id` bigint(20) UNSIGNED NOT NULL,
  `session_key` char(32) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `session_value` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `session_expiry` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_woocommerce_shipping_zones`
--

CREATE TABLE `hc2n_woocommerce_shipping_zones` (
  `zone_id` bigint(20) UNSIGNED NOT NULL,
  `zone_name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `zone_order` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_woocommerce_shipping_zone_locations`
--

CREATE TABLE `hc2n_woocommerce_shipping_zone_locations` (
  `location_id` bigint(20) UNSIGNED NOT NULL,
  `zone_id` bigint(20) UNSIGNED NOT NULL,
  `location_code` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `location_type` varchar(40) COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_woocommerce_shipping_zone_methods`
--

CREATE TABLE `hc2n_woocommerce_shipping_zone_methods` (
  `zone_id` bigint(20) UNSIGNED NOT NULL,
  `instance_id` bigint(20) UNSIGNED NOT NULL,
  `method_id` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `method_order` bigint(20) UNSIGNED NOT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_woocommerce_tax_rates`
--

CREATE TABLE `hc2n_woocommerce_tax_rates` (
  `tax_rate_id` bigint(20) UNSIGNED NOT NULL,
  `tax_rate_country` varchar(2) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `tax_rate_state` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `tax_rate` varchar(8) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `tax_rate_name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `tax_rate_priority` bigint(20) UNSIGNED NOT NULL,
  `tax_rate_compound` int(1) NOT NULL DEFAULT 0,
  `tax_rate_shipping` int(1) NOT NULL DEFAULT 1,
  `tax_rate_order` bigint(20) UNSIGNED NOT NULL,
  `tax_rate_class` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_woocommerce_tax_rate_locations`
--

CREATE TABLE `hc2n_woocommerce_tax_rate_locations` (
  `location_id` bigint(20) UNSIGNED NOT NULL,
  `location_code` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `tax_rate_id` bigint(20) UNSIGNED NOT NULL,
  `location_type` varchar(40) COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wpmailsmtp_debug_events`
--

CREATE TABLE `hc2n_wpmailsmtp_debug_events` (
  `id` int(10) UNSIGNED NOT NULL,
  `content` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `initiator` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `event_type` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wpmailsmtp_tasks_meta`
--

CREATE TABLE `hc2n_wpmailsmtp_tasks_meta` (
  `id` bigint(20) NOT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `data` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wpr_above_the_fold`
--

CREATE TABLE `hc2n_wpr_above_the_fold` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(2000) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `is_mobile` tinyint(1) NOT NULL DEFAULT 0,
  `lcp` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `viewport` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `error_message` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_accessed` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wpr_lazy_render_content`
--

CREATE TABLE `hc2n_wpr_lazy_render_content` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(2000) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `is_mobile` tinyint(1) NOT NULL DEFAULT 0,
  `below_the_fold` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `error_message` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `status` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_accessed` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wpr_preconnect_external_domains`
--

CREATE TABLE `hc2n_wpr_preconnect_external_domains` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(2000) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `is_mobile` tinyint(1) NOT NULL DEFAULT 0,
  `domains` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `error_message` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `status` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_accessed` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wpr_preload_fonts`
--

CREATE TABLE `hc2n_wpr_preload_fonts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(2000) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `is_mobile` tinyint(1) NOT NULL DEFAULT 0,
  `fonts` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `error_message` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `status` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_accessed` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wpr_rocket_cache`
--

CREATE TABLE `hc2n_wpr_rocket_cache` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(2000) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `status` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_accessed` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_locked` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wpr_rucss_used_css`
--

CREATE TABLE `hc2n_wpr_rucss_used_css` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(2000) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `css` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `hash` varchar(32) COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `error_code` varchar(32) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `error_message` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `unprocessedcss` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `retries` tinyint(1) NOT NULL DEFAULT 1,
  `is_mobile` tinyint(1) NOT NULL DEFAULT 0,
  `job_id` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `queue_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `status` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_accessed` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `submitted_at` timestamp NULL DEFAULT NULL,
  `next_retry_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wsal_metadata`
--

CREATE TABLE `hc2n_wsal_metadata` (
  `id` bigint(20) NOT NULL,
  `occurrence_id` bigint(20) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_wsal_occurrences`
--

CREATE TABLE `hc2n_wsal_occurrences` (
  `id` bigint(20) NOT NULL,
  `site_id` bigint(20) NOT NULL,
  `alert_id` bigint(20) NOT NULL,
  `created_on` double NOT NULL,
  `client_ip` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `severity` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `object` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `event_type` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_roles` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `session_id` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_status` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_type` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_yoast_indexable`
--

CREATE TABLE `hc2n_yoast_indexable` (
  `id` int(11) UNSIGNED NOT NULL,
  `permalink` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `permalink_hash` varchar(40) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `object_id` bigint(20) DEFAULT NULL,
  `object_type` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `object_sub_type` varchar(32) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `author_id` bigint(20) DEFAULT NULL,
  `post_parent` bigint(20) DEFAULT NULL,
  `title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `breadcrumb_title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `post_status` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT NULL,
  `is_protected` tinyint(1) DEFAULT 0,
  `has_public_posts` tinyint(1) DEFAULT NULL,
  `number_of_pages` int(11) UNSIGNED DEFAULT NULL,
  `canonical` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `primary_focus_keyword` varchar(191) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `primary_focus_keyword_score` int(3) DEFAULT NULL,
  `readability_score` int(3) DEFAULT NULL,
  `is_cornerstone` tinyint(1) DEFAULT 0,
  `is_robots_noindex` tinyint(1) DEFAULT 0,
  `is_robots_nofollow` tinyint(1) DEFAULT 0,
  `is_robots_noarchive` tinyint(1) DEFAULT 0,
  `is_robots_noimageindex` tinyint(1) DEFAULT 0,
  `is_robots_nosnippet` tinyint(1) DEFAULT 0,
  `twitter_title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_image` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_description` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_image_id` varchar(191) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_image_source` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `open_graph_title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `open_graph_description` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `open_graph_image` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `open_graph_image_id` varchar(191) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `open_graph_image_source` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `open_graph_image_meta` mediumtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `link_count` int(11) DEFAULT NULL,
  `incoming_link_count` int(11) DEFAULT NULL,
  `prominent_words_version` int(11) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `blog_id` bigint(20) NOT NULL DEFAULT 1,
  `language` varchar(32) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `region` varchar(32) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `schema_page_type` varchar(64) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `schema_article_type` varchar(64) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `has_ancestors` tinyint(1) DEFAULT 0,
  `estimated_reading_time_minutes` int(11) DEFAULT NULL,
  `version` int(11) DEFAULT 1,
  `object_last_modified` datetime DEFAULT NULL,
  `object_published_at` datetime DEFAULT NULL,
  `inclusive_language_score` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_yoast_indexable_hierarchy`
--

CREATE TABLE `hc2n_yoast_indexable_hierarchy` (
  `indexable_id` int(11) UNSIGNED NOT NULL,
  `ancestor_id` int(11) UNSIGNED NOT NULL,
  `depth` int(11) UNSIGNED DEFAULT NULL,
  `blog_id` bigint(20) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_yoast_migrations`
--

CREATE TABLE `hc2n_yoast_migrations` (
  `id` int(11) UNSIGNED NOT NULL,
  `version` varchar(191) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_yoast_primary_term`
--

CREATE TABLE `hc2n_yoast_primary_term` (
  `id` int(11) UNSIGNED NOT NULL,
  `post_id` bigint(20) DEFAULT NULL,
  `term_id` bigint(20) DEFAULT NULL,
  `taxonomy` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `blog_id` bigint(20) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hc2n_yoast_seo_links`
--

CREATE TABLE `hc2n_yoast_seo_links` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `post_id` bigint(20) UNSIGNED DEFAULT NULL,
  `target_post_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` varchar(8) DEFAULT NULL,
  `indexable_id` int(11) UNSIGNED DEFAULT NULL,
  `target_indexable_id` int(11) UNSIGNED DEFAULT NULL,
  `height` int(11) UNSIGNED DEFAULT NULL,
  `width` int(11) UNSIGNED DEFAULT NULL,
  `size` int(11) UNSIGNED DEFAULT NULL,
  `language` varchar(32) DEFAULT NULL,
  `region` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `hc2n_actionscheduler_actions`
--
ALTER TABLE `hc2n_actionscheduler_actions`
  ADD PRIMARY KEY (`action_id`),
  ADD KEY `hook` (`hook`),
  ADD KEY `status` (`status`),
  ADD KEY `scheduled_date_gmt` (`scheduled_date_gmt`),
  ADD KEY `args` (`args`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `last_attempt_gmt` (`last_attempt_gmt`),
  ADD KEY `claim_id_status_scheduled_date_gmt` (`claim_id`,`status`,`scheduled_date_gmt`),
  ADD KEY `hook_status_scheduled_date_gmt` (`hook`(163),`status`,`scheduled_date_gmt`),
  ADD KEY `status_scheduled_date_gmt` (`status`,`scheduled_date_gmt`);

--
-- Indexes for table `hc2n_actionscheduler_claims`
--
ALTER TABLE `hc2n_actionscheduler_claims`
  ADD PRIMARY KEY (`claim_id`),
  ADD KEY `date_created_gmt` (`date_created_gmt`);

--
-- Indexes for table `hc2n_actionscheduler_groups`
--
ALTER TABLE `hc2n_actionscheduler_groups`
  ADD PRIMARY KEY (`group_id`),
  ADD KEY `slug` (`slug`(191));

--
-- Indexes for table `hc2n_actionscheduler_logs`
--
ALTER TABLE `hc2n_actionscheduler_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `action_id` (`action_id`),
  ADD KEY `log_date_gmt` (`log_date_gmt`);

--
-- Indexes for table `hc2n_affiliate_wp_affiliatemeta`
--
ALTER TABLE `hc2n_affiliate_wp_affiliatemeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `affiliate_id` (`affiliate_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `hc2n_affiliate_wp_affiliates`
--
ALTER TABLE `hc2n_affiliate_wp_affiliates`
  ADD PRIMARY KEY (`affiliate_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `hc2n_affiliate_wp_campaigns`
--
ALTER TABLE `hc2n_affiliate_wp_campaigns`
  ADD PRIMARY KEY (`campaign_id`),
  ADD KEY `affiliate_id` (`affiliate_id`),
  ADD KEY `hash` (`hash`);

--
-- Indexes for table `hc2n_affiliate_wp_connections`
--
ALTER TABLE `hc2n_affiliate_wp_connections`
  ADD PRIMARY KEY (`connection_id`);

--
-- Indexes for table `hc2n_affiliate_wp_coupons`
--
ALTER TABLE `hc2n_affiliate_wp_coupons`
  ADD PRIMARY KEY (`coupon_id`),
  ADD KEY `coupon_code` (`coupon_code`);

--
-- Indexes for table `hc2n_affiliate_wp_creativemeta`
--
ALTER TABLE `hc2n_affiliate_wp_creativemeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `creative_id` (`creative_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `hc2n_affiliate_wp_creatives`
--
ALTER TABLE `hc2n_affiliate_wp_creatives`
  ADD PRIMARY KEY (`creative_id`),
  ADD KEY `creative_id` (`creative_id`);

--
-- Indexes for table `hc2n_affiliate_wp_customermeta`
--
ALTER TABLE `hc2n_affiliate_wp_customermeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `affwp_customer_id` (`affwp_customer_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `hc2n_affiliate_wp_customers`
--
ALTER TABLE `hc2n_affiliate_wp_customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `hc2n_affiliate_wp_custom_links`
--
ALTER TABLE `hc2n_affiliate_wp_custom_links`
  ADD PRIMARY KEY (`custom_link_id`),
  ADD KEY `custom_link_id` (`custom_link_id`);

--
-- Indexes for table `hc2n_affiliate_wp_groups`
--
ALTER TABLE `hc2n_affiliate_wp_groups`
  ADD PRIMARY KEY (`group_id`);

--
-- Indexes for table `hc2n_affiliate_wp_lifetime_customers`
--
ALTER TABLE `hc2n_affiliate_wp_lifetime_customers`
  ADD PRIMARY KEY (`lifetime_customer_id`),
  ADD KEY `affwp_customer_id` (`affwp_customer_id`);

--
-- Indexes for table `hc2n_affiliate_wp_notifications`
--
ALTER TABLE `hc2n_affiliate_wp_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dismissed_start_end` (`dismissed`,`start`,`end`);

--
-- Indexes for table `hc2n_affiliate_wp_payouts`
--
ALTER TABLE `hc2n_affiliate_wp_payouts`
  ADD PRIMARY KEY (`payout_id`),
  ADD KEY `affiliate_id` (`affiliate_id`),
  ADD KEY `service_id` (`service_id`);

--
-- Indexes for table `hc2n_affiliate_wp_referralmeta`
--
ALTER TABLE `hc2n_affiliate_wp_referralmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `referral_id` (`referral_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `hc2n_affiliate_wp_referrals`
--
ALTER TABLE `hc2n_affiliate_wp_referrals`
  ADD PRIMARY KEY (`referral_id`),
  ADD KEY `affiliate_id` (`affiliate_id`);

--
-- Indexes for table `hc2n_affiliate_wp_rest_consumers`
--
ALTER TABLE `hc2n_affiliate_wp_rest_consumers`
  ADD PRIMARY KEY (`consumer_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `hc2n_affiliate_wp_sales`
--
ALTER TABLE `hc2n_affiliate_wp_sales`
  ADD PRIMARY KEY (`referral_id`),
  ADD KEY `affiliate_id` (`affiliate_id`);

--
-- Indexes for table `hc2n_affiliate_wp_visits`
--
ALTER TABLE `hc2n_affiliate_wp_visits`
  ADD PRIMARY KEY (`visit_id`),
  ADD KEY `affiliate_id` (`affiliate_id`);

--
-- Indexes for table `hc2n_aioseo_cache`
--
ALTER TABLE `hc2n_aioseo_cache`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ndx_aioseo_cache_key` (`key`),
  ADD KEY `ndx_aioseo_cache_expiration` (`expiration`);

--
-- Indexes for table `hc2n_aioseo_notifications`
--
ALTER TABLE `hc2n_aioseo_notifications`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ndx_aioseo_notifications_slug` (`slug`),
  ADD KEY `ndx_aioseo_notifications_dates` (`start`,`end`),
  ADD KEY `ndx_aioseo_notifications_type` (`type`),
  ADD KEY `ndx_aioseo_notifications_dismissed` (`dismissed`);

--
-- Indexes for table `hc2n_aioseo_posts`
--
ALTER TABLE `hc2n_aioseo_posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ndx_aioseo_posts_post_id` (`post_id`);

--
-- Indexes for table `hc2n_bb_background_job_queue`
--
ALTER TABLE `hc2n_bb_background_job_queue`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type` (`type`),
  ADD KEY `group` (`group`),
  ADD KEY `data_id` (`data_id`),
  ADD KEY `secondary_data_id` (`secondary_data_id`),
  ADD KEY `priority` (`priority`),
  ADD KEY `blog_id` (`blog_id`),
  ADD KEY `date_created` (`date_created`);

--
-- Indexes for table `hc2n_bb_background_process_logs`
--
ALTER TABLE `hc2n_bb_background_process_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `process_start_date_gmt` (`process_start_date_gmt`);

--
-- Indexes for table `hc2n_bb_email_queue`
--
ALTER TABLE `hc2n_bb_email_queue`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_bb_notifications_subscriptions`
--
ALTER TABLE `hc2n_bb_notifications_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_id` (`blog_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `type` (`type`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `secondary_item_id` (`secondary_item_id`),
  ADD KEY `status` (`status`),
  ADD KEY `date_recorded` (`date_recorded`);

--
-- Indexes for table `hc2n_bb_polls`
--
ALTER TABLE `hc2n_bb_polls`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `item_type` (`item_type`),
  ADD KEY `secondary_item_id` (`secondary_item_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `date_recorded` (`date_recorded`),
  ADD KEY `date_updated` (`date_updated`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `hc2n_bb_poll_options`
--
ALTER TABLE `hc2n_bb_poll_options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `poll_id` (`poll_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `option_title` (`option_title`),
  ADD KEY `option_order` (`option_order`),
  ADD KEY `date_recorded` (`date_recorded`),
  ADD KEY `date_updated` (`date_updated`);

--
-- Indexes for table `hc2n_bb_poll_votes`
--
ALTER TABLE `hc2n_bb_poll_votes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `poll_id` (`poll_id`),
  ADD KEY `option_id` (`option_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `date_recorded` (`date_recorded`);

--
-- Indexes for table `hc2n_bb_reactions_data`
--
ALTER TABLE `hc2n_bb_reactions_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`),
  ADD KEY `rel1` (`rel1`),
  ADD KEY `rel2` (`rel2`),
  ADD KEY `rel3` (`rel3`),
  ADD KEY `date` (`date`);

--
-- Indexes for table `hc2n_bb_social_sign_on_users`
--
ALTER TABLE `hc2n_bb_social_sign_on_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wp_user_id` (`wp_user_id`,`type`),
  ADD KEY `identifier` (`identifier`),
  ADD KEY `first_name` (`first_name`),
  ADD KEY `last_name` (`last_name`);

--
-- Indexes for table `hc2n_bb_user_reactions`
--
ALTER TABLE `hc2n_bb_user_reactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `reaction_id` (`reaction_id`),
  ADD KEY `item_type` (`item_type`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `date_created` (`date_created`);

--
-- Indexes for table `hc2n_bb_xprofile_visibility`
--
ALTER TABLE `hc2n_bb_xprofile_visibility`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_field_id_user_id` (`field_id`,`user_id`),
  ADD KEY `field_id` (`field_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `value` (`value`);

--
-- Indexes for table `hc2n_bp_activity`
--
ALTER TABLE `hc2n_bp_activity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `date_recorded` (`date_recorded`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `secondary_item_id` (`secondary_item_id`),
  ADD KEY `component` (`component`),
  ADD KEY `type` (`type`),
  ADD KEY `mptt_left` (`mptt_left`),
  ADD KEY `mptt_right` (`mptt_right`),
  ADD KEY `hide_sitewide` (`hide_sitewide`),
  ADD KEY `is_spam` (`is_spam`),
  ADD KEY `date_updated` (`date_updated`);

--
-- Indexes for table `hc2n_bp_activity_meta`
--
ALTER TABLE `hc2n_bp_activity_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `activity_id` (`activity_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `hc2n_bp_document`
--
ALTER TABLE `hc2n_bp_document`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attachment_id` (`attachment_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `folder_id` (`folder_id`),
  ADD KEY `document_author_id` (`folder_id`,`user_id`),
  ADD KEY `activity_id` (`activity_id`),
  ADD KEY `blog_id` (`blog_id`),
  ADD KEY `message_id` (`message_id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `privacy` (`privacy`),
  ADD KEY `menu_order` (`menu_order`),
  ADD KEY `date_created` (`date_created`),
  ADD KEY `date_modified` (`date_modified`),
  ADD KEY `blog_id_2` (`blog_id`),
  ADD KEY `message_id_2` (`message_id`),
  ADD KEY `group_id_2` (`group_id`),
  ADD KEY `privacy_2` (`privacy`),
  ADD KEY `menu_order_2` (`menu_order`),
  ADD KEY `date_created_2` (`date_created`),
  ADD KEY `date_modified_2` (`date_modified`);

--
-- Indexes for table `hc2n_bp_document_folder`
--
ALTER TABLE `hc2n_bp_document_folder`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_bp_document_folder_meta`
--
ALTER TABLE `hc2n_bp_document_folder_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `folder_id` (`folder_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `hc2n_bp_document_meta`
--
ALTER TABLE `hc2n_bp_document_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `document_id` (`document_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `hc2n_bp_follow`
--
ALTER TABLE `hc2n_bp_follow`
  ADD PRIMARY KEY (`id`),
  ADD KEY `followers` (`leader_id`,`follower_id`);

--
-- Indexes for table `hc2n_bp_friends`
--
ALTER TABLE `hc2n_bp_friends`
  ADD PRIMARY KEY (`id`),
  ADD KEY `initiator_user_id` (`initiator_user_id`),
  ADD KEY `friend_user_id` (`friend_user_id`);

--
-- Indexes for table `hc2n_bp_groups`
--
ALTER TABLE `hc2n_bp_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `creator_id` (`creator_id`),
  ADD KEY `status` (`status`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `hc2n_bp_groups_groupmeta`
--
ALTER TABLE `hc2n_bp_groups_groupmeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `hc2n_bp_groups_membermeta`
--
ALTER TABLE `hc2n_bp_groups_membermeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_id` (`member_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `hc2n_bp_groups_members`
--
ALTER TABLE `hc2n_bp_groups_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `is_admin` (`is_admin`),
  ADD KEY `is_mod` (`is_mod`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `inviter_id` (`inviter_id`),
  ADD KEY `is_confirmed` (`is_confirmed`);

--
-- Indexes for table `hc2n_bp_invitations`
--
ALTER TABLE `hc2n_bp_invitations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `inviter_id` (`inviter_id`),
  ADD KEY `invitee_email` (`invitee_email`),
  ADD KEY `class` (`class`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `secondary_item_id` (`secondary_item_id`),
  ADD KEY `type` (`type`),
  ADD KEY `invite_sent` (`invite_sent`),
  ADD KEY `accepted` (`accepted`);

--
-- Indexes for table `hc2n_bp_invitations_invitemeta`
--
ALTER TABLE `hc2n_bp_invitations_invitemeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invite_id` (`invite_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `hc2n_bp_media`
--
ALTER TABLE `hc2n_bp_media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attachment_id` (`attachment_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `album_id` (`album_id`),
  ADD KEY `media_author_id` (`album_id`,`user_id`),
  ADD KEY `activity_id` (`activity_id`),
  ADD KEY `blog_id` (`blog_id`),
  ADD KEY `message_id` (`message_id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `privacy` (`privacy`),
  ADD KEY `type` (`type`),
  ADD KEY `menu_order` (`menu_order`),
  ADD KEY `date_created` (`date_created`),
  ADD KEY `blog_id_2` (`blog_id`),
  ADD KEY `message_id_2` (`message_id`),
  ADD KEY `group_id_2` (`group_id`),
  ADD KEY `privacy_2` (`privacy`),
  ADD KEY `type_2` (`type`),
  ADD KEY `menu_order_2` (`menu_order`),
  ADD KEY `date_created_2` (`date_created`);

--
-- Indexes for table `hc2n_bp_media_albums`
--
ALTER TABLE `hc2n_bp_media_albums`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_bp_messages_messages`
--
ALTER TABLE `hc2n_bp_messages_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `thread_id` (`thread_id`);

--
-- Indexes for table `hc2n_bp_messages_meta`
--
ALTER TABLE `hc2n_bp_messages_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `message_id` (`message_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `hc2n_bp_messages_notices`
--
ALTER TABLE `hc2n_bp_messages_notices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `is_active` (`is_active`);

--
-- Indexes for table `hc2n_bp_messages_recipients`
--
ALTER TABLE `hc2n_bp_messages_recipients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `thread_id` (`thread_id`),
  ADD KEY `is_deleted` (`is_deleted`),
  ADD KEY `sender_only` (`sender_only`),
  ADD KEY `unread_count` (`unread_count`),
  ADD KEY `is_hidden` (`is_hidden`);

--
-- Indexes for table `hc2n_bp_moderation`
--
ALTER TABLE `hc2n_bp_moderation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `moderation_report_id` (`moderation_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `hc2n_bp_moderation_meta`
--
ALTER TABLE `hc2n_bp_moderation_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `moderation_id` (`moderation_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `hc2n_bp_notifications`
--
ALTER TABLE `hc2n_bp_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `secondary_item_id` (`secondary_item_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `is_new` (`is_new`),
  ADD KEY `component_name` (`component_name`),
  ADD KEY `component_action` (`component_action`),
  ADD KEY `useritem` (`user_id`,`is_new`);

--
-- Indexes for table `hc2n_bp_notifications_meta`
--
ALTER TABLE `hc2n_bp_notifications_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notification_id` (`notification_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `hc2n_bp_optouts`
--
ALTER TABLE `hc2n_bp_optouts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `email_type` (`email_type`),
  ADD KEY `date_modified` (`date_modified`);

--
-- Indexes for table `hc2n_bp_suspend`
--
ALTER TABLE `hc2n_bp_suspend`
  ADD PRIMARY KEY (`id`),
  ADD KEY `suspend_item_id` (`item_id`,`item_type`,`blog_id`),
  ADD KEY `suspend_item` (`item_id`,`item_type`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `user_suspended` (`user_suspended`),
  ADD KEY `hide_parent` (`hide_parent`),
  ADD KEY `hide_sitewide` (`hide_sitewide`),
  ADD KEY `suspend_conditions` (`user_suspended`,`hide_parent`,`hide_sitewide`);

--
-- Indexes for table `hc2n_bp_suspend_details`
--
ALTER TABLE `hc2n_bp_suspend_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `suspend_details_id` (`suspend_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `hc2n_bp_suspend_meta`
--
ALTER TABLE `hc2n_bp_suspend_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `suspend_id` (`suspend_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `hc2n_bp_xprofile_data`
--
ALTER TABLE `hc2n_bp_xprofile_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `field_id` (`field_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `hc2n_bp_xprofile_fields`
--
ALTER TABLE `hc2n_bp_xprofile_fields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `field_order` (`field_order`),
  ADD KEY `can_delete` (`can_delete`),
  ADD KEY `is_required` (`is_required`);

--
-- Indexes for table `hc2n_bp_xprofile_groups`
--
ALTER TABLE `hc2n_bp_xprofile_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `can_delete` (`can_delete`);

--
-- Indexes for table `hc2n_bp_xprofile_meta`
--
ALTER TABLE `hc2n_bp_xprofile_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `object_id` (`object_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `hc2n_bp_zoom_meetings`
--
ALTER TABLE `hc2n_bp_zoom_meetings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `activity_id` (`activity_id`),
  ADD KEY `meeting_id` (`meeting_id`);

--
-- Indexes for table `hc2n_bp_zoom_meeting_meta`
--
ALTER TABLE `hc2n_bp_zoom_meeting_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meeting_id` (`meeting_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `hc2n_bp_zoom_recordings`
--
ALTER TABLE `hc2n_bp_zoom_recordings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recording_id` (`recording_id`),
  ADD KEY `meeting_id` (`meeting_id`);

--
-- Indexes for table `hc2n_bp_zoom_webinars`
--
ALTER TABLE `hc2n_bp_zoom_webinars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `activity_id` (`activity_id`),
  ADD KEY `webinar_id` (`webinar_id`);

--
-- Indexes for table `hc2n_bp_zoom_webinar_meta`
--
ALTER TABLE `hc2n_bp_zoom_webinar_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `webinar_id` (`webinar_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `hc2n_bp_zoom_webinar_recordings`
--
ALTER TABLE `hc2n_bp_zoom_webinar_recordings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recording_id` (`recording_id`),
  ADD KEY `webinar_id` (`webinar_id`);

--
-- Indexes for table `hc2n_commentmeta`
--
ALTER TABLE `hc2n_commentmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `comment_id` (`comment_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `hc2n_comments`
--
ALTER TABLE `hc2n_comments`
  ADD PRIMARY KEY (`comment_ID`),
  ADD KEY `comment_post_ID` (`comment_post_ID`),
  ADD KEY `comment_approved_date_gmt` (`comment_approved`,`comment_date_gmt`),
  ADD KEY `comment_date_gmt` (`comment_date_gmt`),
  ADD KEY `comment_parent` (`comment_parent`),
  ADD KEY `comment_author_email` (`comment_author_email`(10)),
  ADD KEY `woo_idx_comment_type` (`comment_type`);

--
-- Indexes for table `hc2n_e_events`
--
ALTER TABLE `hc2n_e_events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_at_index` (`created_at`);

--
-- Indexes for table `hc2n_e_notes`
--
ALTER TABLE `hc2n_e_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `route_url_index` (`route_url`(191)),
  ADD KEY `post_id_index` (`post_id`),
  ADD KEY `element_id_index` (`element_id`),
  ADD KEY `parent_id_index` (`parent_id`),
  ADD KEY `author_id_index` (`author_id`),
  ADD KEY `status_index` (`status`),
  ADD KEY `is_resolved_index` (`is_resolved`),
  ADD KEY `is_public_index` (`is_public`),
  ADD KEY `created_at_index` (`created_at`),
  ADD KEY `updated_at_index` (`updated_at`),
  ADD KEY `last_activity_at_index` (`last_activity_at`);

--
-- Indexes for table `hc2n_e_notes_users_relations`
--
ALTER TABLE `hc2n_e_notes_users_relations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type_index` (`type`),
  ADD KEY `note_id_index` (`note_id`),
  ADD KEY `user_id_index` (`user_id`);

--
-- Indexes for table `hc2n_e_submissions`
--
ALTER TABLE `hc2n_e_submissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `hash_id_unique_index` (`hash_id`),
  ADD KEY `main_meta_id_index` (`main_meta_id`),
  ADD KEY `hash_id_index` (`hash_id`),
  ADD KEY `type_index` (`type`),
  ADD KEY `post_id_index` (`post_id`),
  ADD KEY `element_id_index` (`element_id`),
  ADD KEY `campaign_id_index` (`campaign_id`),
  ADD KEY `user_id_index` (`user_id`),
  ADD KEY `user_ip_index` (`user_ip`),
  ADD KEY `status_index` (`status`),
  ADD KEY `is_read_index` (`is_read`),
  ADD KEY `created_at_gmt_index` (`created_at_gmt`),
  ADD KEY `updated_at_gmt_index` (`updated_at_gmt`),
  ADD KEY `created_at_index` (`created_at`),
  ADD KEY `updated_at_index` (`updated_at`),
  ADD KEY `referer_index` (`referer`(191)),
  ADD KEY `referer_title_index` (`referer_title`(191));

--
-- Indexes for table `hc2n_e_submissions_actions_log`
--
ALTER TABLE `hc2n_e_submissions_actions_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submission_id_index` (`submission_id`),
  ADD KEY `action_name_index` (`action_name`),
  ADD KEY `status_index` (`status`),
  ADD KEY `created_at_gmt_index` (`created_at_gmt`),
  ADD KEY `updated_at_gmt_index` (`updated_at_gmt`),
  ADD KEY `created_at_index` (`created_at`),
  ADD KEY `updated_at_index` (`updated_at`);

--
-- Indexes for table `hc2n_e_submissions_values`
--
ALTER TABLE `hc2n_e_submissions_values`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submission_id_index` (`submission_id`),
  ADD KEY `key_index` (`key`);

--
-- Indexes for table `hc2n_facetwp_cache`
--
ALTER TABLE `hc2n_facetwp_cache`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uri_idx` (`uri`);

--
-- Indexes for table `hc2n_facetwp_index`
--
ALTER TABLE `hc2n_facetwp_index`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id_idx` (`post_id`),
  ADD KEY `facet_name_idx` (`facet_name`),
  ADD KEY `facet_name_value_idx` (`facet_name`,`facet_value`);

--
-- Indexes for table `hc2n_gf_addon_feed`
--
ALTER TABLE `hc2n_gf_addon_feed`
  ADD PRIMARY KEY (`id`),
  ADD KEY `addon_form` (`addon_slug`,`form_id`);

--
-- Indexes for table `hc2n_gf_addon_payment_callback`
--
ALTER TABLE `hc2n_gf_addon_payment_callback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `addon_slug_callback_id` (`addon_slug`(50),`callback_id`(100));

--
-- Indexes for table `hc2n_gf_addon_payment_transaction`
--
ALTER TABLE `hc2n_gf_addon_payment_transaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lead_id` (`lead_id`),
  ADD KEY `transaction_type` (`transaction_type`),
  ADD KEY `type_lead` (`lead_id`,`transaction_type`);

--
-- Indexes for table `hc2n_gf_draft_submissions`
--
ALTER TABLE `hc2n_gf_draft_submissions`
  ADD PRIMARY KEY (`uuid`),
  ADD KEY `form_id` (`form_id`);

--
-- Indexes for table `hc2n_gf_entry`
--
ALTER TABLE `hc2n_gf_entry`
  ADD PRIMARY KEY (`id`),
  ADD KEY `form_id` (`form_id`),
  ADD KEY `form_id_status` (`form_id`,`status`);

--
-- Indexes for table `hc2n_gf_entry_meta`
--
ALTER TABLE `hc2n_gf_entry_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meta_key` (`meta_key`(191)),
  ADD KEY `entry_id` (`entry_id`),
  ADD KEY `meta_value` (`meta_value`(191));

--
-- Indexes for table `hc2n_gf_entry_notes`
--
ALTER TABLE `hc2n_gf_entry_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `entry_id` (`entry_id`),
  ADD KEY `entry_user_key` (`entry_id`,`user_id`);

--
-- Indexes for table `hc2n_gf_form`
--
ALTER TABLE `hc2n_gf_form`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_gf_form_meta`
--
ALTER TABLE `hc2n_gf_form_meta`
  ADD PRIMARY KEY (`form_id`);

--
-- Indexes for table `hc2n_gf_form_revisions`
--
ALTER TABLE `hc2n_gf_form_revisions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `date_created` (`date_created`),
  ADD KEY `form_id` (`form_id`);

--
-- Indexes for table `hc2n_gf_form_view`
--
ALTER TABLE `hc2n_gf_form_view`
  ADD PRIMARY KEY (`id`),
  ADD KEY `date_created` (`date_created`),
  ADD KEY `form_id` (`form_id`);

--
-- Indexes for table `hc2n_gf_rest_api_keys`
--
ALTER TABLE `hc2n_gf_rest_api_keys`
  ADD PRIMARY KEY (`key_id`),
  ADD KEY `consumer_key` (`consumer_key`),
  ADD KEY `consumer_secret` (`consumer_secret`);

--
-- Indexes for table `hc2n_links`
--
ALTER TABLE `hc2n_links`
  ADD PRIMARY KEY (`link_id`),
  ADD KEY `link_visible` (`link_visible`);

--
-- Indexes for table `hc2n_options`
--
ALTER TABLE `hc2n_options`
  ADD PRIMARY KEY (`option_id`),
  ADD UNIQUE KEY `option_name` (`option_name`),
  ADD KEY `autoload` (`autoload`);

--
-- Indexes for table `hc2n_pmxi_files`
--
ALTER TABLE `hc2n_pmxi_files`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_pmxi_geocoding`
--
ALTER TABLE `hc2n_pmxi_geocoding`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_address` (`address`(255)),
  ADD KEY `idx_coordinates` (`latitude`,`longitude`);

--
-- Indexes for table `hc2n_pmxi_hash`
--
ALTER TABLE `hc2n_pmxi_hash`
  ADD PRIMARY KEY (`hash`);

--
-- Indexes for table `hc2n_pmxi_history`
--
ALTER TABLE `hc2n_pmxi_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_pmxi_images`
--
ALTER TABLE `hc2n_pmxi_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_pmxi_imports`
--
ALTER TABLE `hc2n_pmxi_imports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_pmxi_posts`
--
ALTER TABLE `hc2n_pmxi_posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_pmxi_templates`
--
ALTER TABLE `hc2n_pmxi_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_postmeta`
--
ALTER TABLE `hc2n_postmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `hc2n_posts`
--
ALTER TABLE `hc2n_posts`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `post_name` (`post_name`(191)),
  ADD KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  ADD KEY `post_parent` (`post_parent`),
  ADD KEY `post_author` (`post_author`);
ALTER TABLE `hc2n_posts` ADD FULLTEXT KEY `crp_related` (`post_title`,`post_content`);
ALTER TABLE `hc2n_posts` ADD FULLTEXT KEY `crp_related_title` (`post_title`);
ALTER TABLE `hc2n_posts` ADD FULLTEXT KEY `crp_related_content` (`post_content`);

--
-- Indexes for table `hc2n_post_smtp_logmeta`
--
ALTER TABLE `hc2n_post_smtp_logmeta`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_post_smtp_logs`
--
ALTER TABLE `hc2n_post_smtp_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_pronamic_pay_mollie_customers`
--
ALTER TABLE `hc2n_pronamic_pay_mollie_customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mollie_id` (`mollie_id`),
  ADD KEY `organization_id` (`organization_id`),
  ADD KEY `profile_id` (`profile_id`),
  ADD KEY `test_mode` (`test_mode`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `hc2n_pronamic_pay_mollie_customer_users`
--
ALTER TABLE `hc2n_pronamic_pay_mollie_customer_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customer_user` (`customer_id`,`user_id`),
  ADD KEY `fk_customer_user_id` (`user_id`);

--
-- Indexes for table `hc2n_pronamic_pay_mollie_organizations`
--
ALTER TABLE `hc2n_pronamic_pay_mollie_organizations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mollie_id` (`mollie_id`);

--
-- Indexes for table `hc2n_pronamic_pay_mollie_profiles`
--
ALTER TABLE `hc2n_pronamic_pay_mollie_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mollie_id` (`mollie_id`),
  ADD KEY `organization_id` (`organization_id`);

--
-- Indexes for table `hc2n_redirection_404`
--
ALTER TABLE `hc2n_redirection_404`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created` (`created`),
  ADD KEY `referrer` (`referrer`(191)),
  ADD KEY `ip` (`ip`);

--
-- Indexes for table `hc2n_redirection_groups`
--
ALTER TABLE `hc2n_redirection_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `module_id` (`module_id`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `hc2n_redirection_items`
--
ALTER TABLE `hc2n_redirection_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `url` (`url`(191)),
  ADD KEY `status` (`status`),
  ADD KEY `regex` (`regex`),
  ADD KEY `group_idpos` (`group_id`,`position`),
  ADD KEY `group` (`group_id`),
  ADD KEY `match_url` (`match_url`(191));

--
-- Indexes for table `hc2n_redirection_logs`
--
ALTER TABLE `hc2n_redirection_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created` (`created`),
  ADD KEY `redirection_id` (`redirection_id`),
  ADD KEY `ip` (`ip`);

--
-- Indexes for table `hc2n_rp4wp_cache`
--
ALTER TABLE `hc2n_rp4wp_cache`
  ADD PRIMARY KEY (`post_id`,`word`);

--
-- Indexes for table `hc2n_rtwapwcm_mlm`
--
ALTER TABLE `hc2n_rtwapwcm_mlm`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_rtwapwcm_referrals`
--
ALTER TABLE `hc2n_rtwapwcm_referrals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_rtwapwcm_referral_link`
--
ALTER TABLE `hc2n_rtwapwcm_referral_link`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_rtwapwcm_visitors_track`
--
ALTER TABLE `hc2n_rtwapwcm_visitors_track`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_rtwapwcm_wallet_transaction`
--
ALTER TABLE `hc2n_rtwapwcm_wallet_transaction`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_signups`
--
ALTER TABLE `hc2n_signups`
  ADD PRIMARY KEY (`signup_id`),
  ADD KEY `activation_key` (`activation_key`),
  ADD KEY `user_email` (`user_email`),
  ADD KEY `user_login_email` (`user_login`,`user_email`),
  ADD KEY `domain_path` (`domain`(140),`path`(51));

--
-- Indexes for table `hc2n_termmeta`
--
ALTER TABLE `hc2n_termmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `term_id` (`term_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `hc2n_terms`
--
ALTER TABLE `hc2n_terms`
  ADD PRIMARY KEY (`term_id`),
  ADD KEY `slug` (`slug`(191)),
  ADD KEY `name` (`name`(191));

--
-- Indexes for table `hc2n_term_relationships`
--
ALTER TABLE `hc2n_term_relationships`
  ADD PRIMARY KEY (`object_id`,`term_taxonomy_id`),
  ADD KEY `term_taxonomy_id` (`term_taxonomy_id`);

--
-- Indexes for table `hc2n_term_taxonomy`
--
ALTER TABLE `hc2n_term_taxonomy`
  ADD PRIMARY KEY (`term_taxonomy_id`),
  ADD UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  ADD KEY `taxonomy` (`taxonomy`);

--
-- Indexes for table `hc2n_uap_action_log`
--
ALTER TABLE `hc2n_uap_action_log`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `completed` (`completed`),
  ADD KEY `automator_action_id` (`automator_action_id`),
  ADD KEY `automator_recipe_log_id` (`automator_recipe_log_id`),
  ADD KEY `automator_recipe_id` (`automator_recipe_id`);

--
-- Indexes for table `hc2n_uap_action_log_meta`
--
ALTER TABLE `hc2n_uap_action_log_meta`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `automator_action_log_id` (`automator_action_log_id`),
  ADD KEY `automator_action_id` (`automator_action_id`),
  ADD KEY `meta_key` (`meta_key`(20));

--
-- Indexes for table `hc2n_uap_api_log`
--
ALTER TABLE `hc2n_uap_api_log`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `item_log_id` (`item_log_id`);

--
-- Indexes for table `hc2n_uap_closure_log`
--
ALTER TABLE `hc2n_uap_closure_log`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `automator_recipe_id` (`automator_recipe_id`),
  ADD KEY `automator_closure_id` (`automator_closure_id`),
  ADD KEY `completed` (`completed`);

--
-- Indexes for table `hc2n_uap_closure_log_meta`
--
ALTER TABLE `hc2n_uap_closure_log_meta`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `automator_closure_id` (`automator_closure_id`),
  ADD KEY `meta_key` (`meta_key`(15));

--
-- Indexes for table `hc2n_uap_recipe_log`
--
ALTER TABLE `hc2n_uap_recipe_log`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `completed` (`completed`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `automator_recipe_id` (`automator_recipe_id`);

--
-- Indexes for table `hc2n_uap_trigger_log`
--
ALTER TABLE `hc2n_uap_trigger_log`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `completed` (`completed`),
  ADD KEY `automator_recipe_id` (`automator_recipe_id`),
  ADD KEY `automator_trigger_id` (`automator_trigger_id`),
  ADD KEY `automator_recipe_log_id` (`automator_recipe_log_id`);

--
-- Indexes for table `hc2n_uap_trigger_log_meta`
--
ALTER TABLE `hc2n_uap_trigger_log_meta`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `run_number` (`run_number`),
  ADD KEY `automator_trigger_id` (`automator_trigger_id`),
  ADD KEY `automator_trigger_log_id` (`automator_trigger_log_id`),
  ADD KEY `meta_key` (`meta_key`(20));

--
-- Indexes for table `hc2n_umbrella_backup`
--
ALTER TABLE `hc2n_umbrella_backup`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_umbrella_log`
--
ALTER TABLE `hc2n_umbrella_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_code` (`code`);

--
-- Indexes for table `hc2n_umbrella_task_backup`
--
ALTER TABLE `hc2n_umbrella_task_backup`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_usermeta`
--
ALTER TABLE `hc2n_usermeta`
  ADD PRIMARY KEY (`umeta_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `hc2n_users`
--
ALTER TABLE `hc2n_users`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_login_key` (`user_login`),
  ADD KEY `user_nicename` (`user_nicename`),
  ADD KEY `user_email` (`user_email`);

--
-- Indexes for table `hc2n_wc_admin_notes`
--
ALTER TABLE `hc2n_wc_admin_notes`
  ADD PRIMARY KEY (`note_id`);

--
-- Indexes for table `hc2n_wc_admin_note_actions`
--
ALTER TABLE `hc2n_wc_admin_note_actions`
  ADD PRIMARY KEY (`action_id`),
  ADD KEY `note_id` (`note_id`);

--
-- Indexes for table `hc2n_wc_category_lookup`
--
ALTER TABLE `hc2n_wc_category_lookup`
  ADD PRIMARY KEY (`category_tree_id`,`category_id`);

--
-- Indexes for table `hc2n_wc_customer_lookup`
--
ALTER TABLE `hc2n_wc_customer_lookup`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `hc2n_wc_download_log`
--
ALTER TABLE `hc2n_wc_download_log`
  ADD PRIMARY KEY (`download_log_id`),
  ADD KEY `permission_id` (`permission_id`),
  ADD KEY `timestamp` (`timestamp`);

--
-- Indexes for table `hc2n_wc_orders`
--
ALTER TABLE `hc2n_wc_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status` (`status`),
  ADD KEY `date_created` (`date_created_gmt`),
  ADD KEY `customer_id_billing_email` (`customer_id`,`billing_email`(171)),
  ADD KEY `billing_email` (`billing_email`(191)),
  ADD KEY `type_status_date` (`type`,`status`,`date_created_gmt`),
  ADD KEY `parent_order_id` (`parent_order_id`),
  ADD KEY `date_updated` (`date_updated_gmt`);

--
-- Indexes for table `hc2n_wc_orders_meta`
--
ALTER TABLE `hc2n_wc_orders_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meta_key_value` (`meta_key`(100),`meta_value`(82)),
  ADD KEY `order_id_meta_key_meta_value` (`order_id`,`meta_key`(100),`meta_value`(82));

--
-- Indexes for table `hc2n_wc_order_addresses`
--
ALTER TABLE `hc2n_wc_order_addresses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `address_type_order_id` (`address_type`,`order_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `email` (`email`(191)),
  ADD KEY `phone` (`phone`);

--
-- Indexes for table `hc2n_wc_order_coupon_lookup`
--
ALTER TABLE `hc2n_wc_order_coupon_lookup`
  ADD PRIMARY KEY (`order_id`,`coupon_id`),
  ADD KEY `coupon_id` (`coupon_id`),
  ADD KEY `date_created` (`date_created`);

--
-- Indexes for table `hc2n_wc_order_operational_data`
--
ALTER TABLE `hc2n_wc_order_operational_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_id` (`order_id`),
  ADD KEY `order_key` (`order_key`);

--
-- Indexes for table `hc2n_wc_order_product_lookup`
--
ALTER TABLE `hc2n_wc_order_product_lookup`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `date_created` (`date_created`),
  ADD KEY `customer_product_date` (`customer_id`,`product_id`,`date_created`);

--
-- Indexes for table `hc2n_wc_order_stats`
--
ALTER TABLE `hc2n_wc_order_stats`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `date_created` (`date_created`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `status` (`status`(191));

--
-- Indexes for table `hc2n_wc_order_tax_lookup`
--
ALTER TABLE `hc2n_wc_order_tax_lookup`
  ADD PRIMARY KEY (`order_id`,`tax_rate_id`),
  ADD KEY `tax_rate_id` (`tax_rate_id`),
  ADD KEY `date_created` (`date_created`);

--
-- Indexes for table `hc2n_wc_product_attributes_lookup`
--
ALTER TABLE `hc2n_wc_product_attributes_lookup`
  ADD PRIMARY KEY (`product_or_parent_id`,`term_id`,`product_id`,`taxonomy`),
  ADD KEY `is_variation_attribute_term_id` (`is_variation_attribute`,`term_id`);

--
-- Indexes for table `hc2n_wc_product_download_directories`
--
ALTER TABLE `hc2n_wc_product_download_directories`
  ADD PRIMARY KEY (`url_id`),
  ADD KEY `url` (`url`(191));

--
-- Indexes for table `hc2n_wc_product_meta_lookup`
--
ALTER TABLE `hc2n_wc_product_meta_lookup`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `virtual` (`virtual`),
  ADD KEY `downloadable` (`downloadable`),
  ADD KEY `stock_status` (`stock_status`),
  ADD KEY `stock_quantity` (`stock_quantity`),
  ADD KEY `onsale` (`onsale`),
  ADD KEY `min_max_price` (`min_price`,`max_price`),
  ADD KEY `sku` (`sku`(50));

--
-- Indexes for table `hc2n_wc_rate_limits`
--
ALTER TABLE `hc2n_wc_rate_limits`
  ADD PRIMARY KEY (`rate_limit_id`),
  ADD UNIQUE KEY `rate_limit_key` (`rate_limit_key`(191));

--
-- Indexes for table `hc2n_wc_reserved_stock`
--
ALTER TABLE `hc2n_wc_reserved_stock`
  ADD PRIMARY KEY (`order_id`,`product_id`);

--
-- Indexes for table `hc2n_wc_tax_rate_classes`
--
ALTER TABLE `hc2n_wc_tax_rate_classes`
  ADD PRIMARY KEY (`tax_rate_class_id`),
  ADD UNIQUE KEY `slug` (`slug`(191));

--
-- Indexes for table `hc2n_wc_webhooks`
--
ALTER TABLE `hc2n_wc_webhooks`
  ADD PRIMARY KEY (`webhook_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `hc2n_wfauditevents`
--
ALTER TABLE `hc2n_wfauditevents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_wfblockediplog`
--
ALTER TABLE `hc2n_wfblockediplog`
  ADD PRIMARY KEY (`IP`,`unixday`,`blockType`);

--
-- Indexes for table `hc2n_wfblocks7`
--
ALTER TABLE `hc2n_wfblocks7`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type` (`type`),
  ADD KEY `IP` (`IP`),
  ADD KEY `expiration` (`expiration`);

--
-- Indexes for table `hc2n_wfconfig`
--
ALTER TABLE `hc2n_wfconfig`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `hc2n_wfcrawlers`
--
ALTER TABLE `hc2n_wfcrawlers`
  ADD PRIMARY KEY (`IP`,`patternSig`);

--
-- Indexes for table `hc2n_wffilechanges`
--
ALTER TABLE `hc2n_wffilechanges`
  ADD PRIMARY KEY (`filenameHash`);

--
-- Indexes for table `hc2n_wffilemods`
--
ALTER TABLE `hc2n_wffilemods`
  ADD PRIMARY KEY (`filenameMD5`);

--
-- Indexes for table `hc2n_wfhits`
--
ALTER TABLE `hc2n_wfhits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `k1` (`ctime`),
  ADD KEY `k2` (`IP`,`ctime`),
  ADD KEY `attackLogTime` (`attackLogTime`);

--
-- Indexes for table `hc2n_wfhoover`
--
ALTER TABLE `hc2n_wfhoover`
  ADD PRIMARY KEY (`id`),
  ADD KEY `k2` (`hostKey`);

--
-- Indexes for table `hc2n_wfissues`
--
ALTER TABLE `hc2n_wfissues`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lastUpdated` (`lastUpdated`),
  ADD KEY `status` (`status`),
  ADD KEY `ignoreP` (`ignoreP`),
  ADD KEY `ignoreC` (`ignoreC`);

--
-- Indexes for table `hc2n_wfknownfilelist`
--
ALTER TABLE `hc2n_wfknownfilelist`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_wflivetraffichuman`
--
ALTER TABLE `hc2n_wflivetraffichuman`
  ADD PRIMARY KEY (`IP`,`identifier`),
  ADD KEY `expiration` (`expiration`);

--
-- Indexes for table `hc2n_wflocs`
--
ALTER TABLE `hc2n_wflocs`
  ADD PRIMARY KEY (`IP`);

--
-- Indexes for table `hc2n_wflogins`
--
ALTER TABLE `hc2n_wflogins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `k1` (`IP`,`fail`),
  ADD KEY `hitID` (`hitID`);

--
-- Indexes for table `hc2n_wfls_2fa_secrets`
--
ALTER TABLE `hc2n_wfls_2fa_secrets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `hc2n_wfls_role_counts`
--
ALTER TABLE `hc2n_wfls_role_counts`
  ADD PRIMARY KEY (`serialized_roles`,`two_factor_inactive`);

--
-- Indexes for table `hc2n_wfls_settings`
--
ALTER TABLE `hc2n_wfls_settings`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `hc2n_wfnotifications`
--
ALTER TABLE `hc2n_wfnotifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_wfpendingissues`
--
ALTER TABLE `hc2n_wfpendingissues`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lastUpdated` (`lastUpdated`),
  ADD KEY `status` (`status`),
  ADD KEY `ignoreP` (`ignoreP`),
  ADD KEY `ignoreC` (`ignoreC`);

--
-- Indexes for table `hc2n_wfreversecache`
--
ALTER TABLE `hc2n_wfreversecache`
  ADD PRIMARY KEY (`IP`);

--
-- Indexes for table `hc2n_wfsecurityevents`
--
ALTER TABLE `hc2n_wfsecurityevents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_wfsnipcache`
--
ALTER TABLE `hc2n_wfsnipcache`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expiration` (`expiration`),
  ADD KEY `IP` (`IP`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `hc2n_wfstatus`
--
ALTER TABLE `hc2n_wfstatus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `k1` (`ctime`),
  ADD KEY `k2` (`type`);

--
-- Indexes for table `hc2n_wftrafficrates`
--
ALTER TABLE `hc2n_wftrafficrates`
  ADD PRIMARY KEY (`eMin`,`IP`,`hitType`);

--
-- Indexes for table `hc2n_wfwaffailures`
--
ALTER TABLE `hc2n_wfwaffailures`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_woocommerce_api_keys`
--
ALTER TABLE `hc2n_woocommerce_api_keys`
  ADD PRIMARY KEY (`key_id`),
  ADD KEY `consumer_key` (`consumer_key`),
  ADD KEY `consumer_secret` (`consumer_secret`);

--
-- Indexes for table `hc2n_woocommerce_attribute_taxonomies`
--
ALTER TABLE `hc2n_woocommerce_attribute_taxonomies`
  ADD PRIMARY KEY (`attribute_id`),
  ADD KEY `attribute_name` (`attribute_name`(20));

--
-- Indexes for table `hc2n_woocommerce_downloadable_product_permissions`
--
ALTER TABLE `hc2n_woocommerce_downloadable_product_permissions`
  ADD PRIMARY KEY (`permission_id`),
  ADD KEY `download_order_key_product` (`product_id`,`order_id`,`order_key`(16),`download_id`),
  ADD KEY `download_order_product` (`download_id`,`order_id`,`product_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `user_order_remaining_expires` (`user_id`,`order_id`,`downloads_remaining`,`access_expires`);

--
-- Indexes for table `hc2n_woocommerce_log`
--
ALTER TABLE `hc2n_woocommerce_log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `level` (`level`);

--
-- Indexes for table `hc2n_woocommerce_order_itemmeta`
--
ALTER TABLE `hc2n_woocommerce_order_itemmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `order_item_id` (`order_item_id`),
  ADD KEY `meta_key` (`meta_key`(32));

--
-- Indexes for table `hc2n_woocommerce_order_items`
--
ALTER TABLE `hc2n_woocommerce_order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `hc2n_woocommerce_payment_tokenmeta`
--
ALTER TABLE `hc2n_woocommerce_payment_tokenmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `payment_token_id` (`payment_token_id`),
  ADD KEY `meta_key` (`meta_key`(32));

--
-- Indexes for table `hc2n_woocommerce_payment_tokens`
--
ALTER TABLE `hc2n_woocommerce_payment_tokens`
  ADD PRIMARY KEY (`token_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `hc2n_woocommerce_sessions`
--
ALTER TABLE `hc2n_woocommerce_sessions`
  ADD PRIMARY KEY (`session_id`),
  ADD UNIQUE KEY `session_key` (`session_key`);

--
-- Indexes for table `hc2n_woocommerce_shipping_zones`
--
ALTER TABLE `hc2n_woocommerce_shipping_zones`
  ADD PRIMARY KEY (`zone_id`);

--
-- Indexes for table `hc2n_woocommerce_shipping_zone_locations`
--
ALTER TABLE `hc2n_woocommerce_shipping_zone_locations`
  ADD PRIMARY KEY (`location_id`),
  ADD KEY `zone_id` (`zone_id`),
  ADD KEY `location_type_code` (`location_type`(10),`location_code`(20));

--
-- Indexes for table `hc2n_woocommerce_shipping_zone_methods`
--
ALTER TABLE `hc2n_woocommerce_shipping_zone_methods`
  ADD PRIMARY KEY (`instance_id`);

--
-- Indexes for table `hc2n_woocommerce_tax_rates`
--
ALTER TABLE `hc2n_woocommerce_tax_rates`
  ADD PRIMARY KEY (`tax_rate_id`),
  ADD KEY `tax_rate_country` (`tax_rate_country`),
  ADD KEY `tax_rate_state` (`tax_rate_state`(2)),
  ADD KEY `tax_rate_class` (`tax_rate_class`(10)),
  ADD KEY `tax_rate_priority` (`tax_rate_priority`);

--
-- Indexes for table `hc2n_woocommerce_tax_rate_locations`
--
ALTER TABLE `hc2n_woocommerce_tax_rate_locations`
  ADD PRIMARY KEY (`location_id`),
  ADD KEY `tax_rate_id` (`tax_rate_id`),
  ADD KEY `location_type_code` (`location_type`(10),`location_code`(20));

--
-- Indexes for table `hc2n_wpmailsmtp_debug_events`
--
ALTER TABLE `hc2n_wpmailsmtp_debug_events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_wpmailsmtp_tasks_meta`
--
ALTER TABLE `hc2n_wpmailsmtp_tasks_meta`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hc2n_wpr_above_the_fold`
--
ALTER TABLE `hc2n_wpr_above_the_fold`
  ADD PRIMARY KEY (`id`),
  ADD KEY `url` (`url`(150),`is_mobile`),
  ADD KEY `modified` (`modified`),
  ADD KEY `last_accessed` (`last_accessed`),
  ADD KEY `status_index` (`status`(191));

--
-- Indexes for table `hc2n_wpr_lazy_render_content`
--
ALTER TABLE `hc2n_wpr_lazy_render_content`
  ADD PRIMARY KEY (`id`),
  ADD KEY `url` (`url`(150),`is_mobile`),
  ADD KEY `modified` (`modified`),
  ADD KEY `last_accessed` (`last_accessed`),
  ADD KEY `status_index` (`status`(191));

--
-- Indexes for table `hc2n_wpr_preconnect_external_domains`
--
ALTER TABLE `hc2n_wpr_preconnect_external_domains`
  ADD PRIMARY KEY (`id`),
  ADD KEY `url` (`url`(150),`is_mobile`),
  ADD KEY `modified` (`modified`),
  ADD KEY `last_accessed` (`last_accessed`),
  ADD KEY `status_index` (`status`(191));

--
-- Indexes for table `hc2n_wpr_preload_fonts`
--
ALTER TABLE `hc2n_wpr_preload_fonts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `url` (`url`(150),`is_mobile`),
  ADD KEY `modified` (`modified`),
  ADD KEY `last_accessed` (`last_accessed`),
  ADD KEY `status_index` (`status`(191));

--
-- Indexes for table `hc2n_wpr_rocket_cache`
--
ALTER TABLE `hc2n_wpr_rocket_cache`
  ADD PRIMARY KEY (`id`),
  ADD KEY `url` (`url`(191)),
  ADD KEY `modified` (`modified`),
  ADD KEY `last_accessed` (`last_accessed`);

--
-- Indexes for table `hc2n_wpr_rucss_used_css`
--
ALTER TABLE `hc2n_wpr_rucss_used_css`
  ADD PRIMARY KEY (`id`),
  ADD KEY `url` (`url`(150),`is_mobile`),
  ADD KEY `modified` (`modified`),
  ADD KEY `last_accessed` (`last_accessed`),
  ADD KEY `status_index` (`status`(191)),
  ADD KEY `error_code_index` (`error_code`),
  ADD KEY `hash` (`hash`);

--
-- Indexes for table `hc2n_wsal_metadata`
--
ALTER TABLE `hc2n_wsal_metadata`
  ADD PRIMARY KEY (`id`),
  ADD KEY `occurrence_name` (`occurrence_id`,`name`),
  ADD KEY `name_value` (`name`,`value`(64));

--
-- Indexes for table `hc2n_wsal_occurrences`
--
ALTER TABLE `hc2n_wsal_occurrences`
  ADD PRIMARY KEY (`id`),
  ADD KEY `site_alert_created` (`site_id`,`alert_id`,`created_on`),
  ADD KEY `created_on` (`created_on`),
  ADD KEY `wsal_users` (`user_id`,`username`);

--
-- Indexes for table `hc2n_yoast_indexable`
--
ALTER TABLE `hc2n_yoast_indexable`
  ADD PRIMARY KEY (`id`),
  ADD KEY `object_type_and_sub_type` (`object_type`,`object_sub_type`),
  ADD KEY `object_id_and_type` (`object_id`,`object_type`),
  ADD KEY `permalink_hash_and_object_type` (`permalink_hash`,`object_type`),
  ADD KEY `subpages` (`post_parent`,`object_type`,`post_status`,`object_id`),
  ADD KEY `prominent_words` (`prominent_words_version`,`object_type`,`object_sub_type`,`post_status`),
  ADD KEY `published_sitemap_index` (`object_published_at`,`is_robots_noindex`,`object_type`,`object_sub_type`);

--
-- Indexes for table `hc2n_yoast_indexable_hierarchy`
--
ALTER TABLE `hc2n_yoast_indexable_hierarchy`
  ADD PRIMARY KEY (`indexable_id`,`ancestor_id`),
  ADD KEY `indexable_id` (`indexable_id`),
  ADD KEY `ancestor_id` (`ancestor_id`),
  ADD KEY `depth` (`depth`);

--
-- Indexes for table `hc2n_yoast_migrations`
--
ALTER TABLE `hc2n_yoast_migrations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `fngs_yoast_migrations_version` (`version`);

--
-- Indexes for table `hc2n_yoast_primary_term`
--
ALTER TABLE `hc2n_yoast_primary_term`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_taxonomy` (`post_id`,`taxonomy`),
  ADD KEY `post_term` (`post_id`,`term_id`);

--
-- Indexes for table `hc2n_yoast_seo_links`
--
ALTER TABLE `hc2n_yoast_seo_links`
  ADD PRIMARY KEY (`id`),
  ADD KEY `link_direction` (`post_id`,`type`),
  ADD KEY `indexable_link_direction` (`indexable_id`,`type`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `hc2n_actionscheduler_actions`
--
ALTER TABLE `hc2n_actionscheduler_actions`
  MODIFY `action_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_actionscheduler_claims`
--
ALTER TABLE `hc2n_actionscheduler_claims`
  MODIFY `claim_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_actionscheduler_groups`
--
ALTER TABLE `hc2n_actionscheduler_groups`
  MODIFY `group_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_actionscheduler_logs`
--
ALTER TABLE `hc2n_actionscheduler_logs`
  MODIFY `log_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_affiliate_wp_affiliatemeta`
--
ALTER TABLE `hc2n_affiliate_wp_affiliatemeta`
  MODIFY `meta_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_affiliate_wp_affiliates`
--
ALTER TABLE `hc2n_affiliate_wp_affiliates`
  MODIFY `affiliate_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_affiliate_wp_campaigns`
--
ALTER TABLE `hc2n_affiliate_wp_campaigns`
  MODIFY `campaign_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_affiliate_wp_connections`
--
ALTER TABLE `hc2n_affiliate_wp_connections`
  MODIFY `connection_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_affiliate_wp_coupons`
--
ALTER TABLE `hc2n_affiliate_wp_coupons`
  MODIFY `coupon_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_affiliate_wp_creativemeta`
--
ALTER TABLE `hc2n_affiliate_wp_creativemeta`
  MODIFY `meta_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_affiliate_wp_creatives`
--
ALTER TABLE `hc2n_affiliate_wp_creatives`
  MODIFY `creative_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_affiliate_wp_customermeta`
--
ALTER TABLE `hc2n_affiliate_wp_customermeta`
  MODIFY `meta_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_affiliate_wp_customers`
--
ALTER TABLE `hc2n_affiliate_wp_customers`
  MODIFY `customer_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_affiliate_wp_custom_links`
--
ALTER TABLE `hc2n_affiliate_wp_custom_links`
  MODIFY `custom_link_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_affiliate_wp_groups`
--
ALTER TABLE `hc2n_affiliate_wp_groups`
  MODIFY `group_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_affiliate_wp_lifetime_customers`
--
ALTER TABLE `hc2n_affiliate_wp_lifetime_customers`
  MODIFY `lifetime_customer_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_affiliate_wp_notifications`
--
ALTER TABLE `hc2n_affiliate_wp_notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_affiliate_wp_payouts`
--
ALTER TABLE `hc2n_affiliate_wp_payouts`
  MODIFY `payout_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_affiliate_wp_referralmeta`
--
ALTER TABLE `hc2n_affiliate_wp_referralmeta`
  MODIFY `meta_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_affiliate_wp_referrals`
--
ALTER TABLE `hc2n_affiliate_wp_referrals`
  MODIFY `referral_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_affiliate_wp_rest_consumers`
--
ALTER TABLE `hc2n_affiliate_wp_rest_consumers`
  MODIFY `consumer_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_affiliate_wp_visits`
--
ALTER TABLE `hc2n_affiliate_wp_visits`
  MODIFY `visit_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_aioseo_cache`
--
ALTER TABLE `hc2n_aioseo_cache`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_aioseo_notifications`
--
ALTER TABLE `hc2n_aioseo_notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_aioseo_posts`
--
ALTER TABLE `hc2n_aioseo_posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bb_background_job_queue`
--
ALTER TABLE `hc2n_bb_background_job_queue`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bb_background_process_logs`
--
ALTER TABLE `hc2n_bb_background_process_logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bb_email_queue`
--
ALTER TABLE `hc2n_bb_email_queue`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bb_notifications_subscriptions`
--
ALTER TABLE `hc2n_bb_notifications_subscriptions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bb_polls`
--
ALTER TABLE `hc2n_bb_polls`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bb_poll_options`
--
ALTER TABLE `hc2n_bb_poll_options`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bb_poll_votes`
--
ALTER TABLE `hc2n_bb_poll_votes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bb_reactions_data`
--
ALTER TABLE `hc2n_bb_reactions_data`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bb_social_sign_on_users`
--
ALTER TABLE `hc2n_bb_social_sign_on_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bb_user_reactions`
--
ALTER TABLE `hc2n_bb_user_reactions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bb_xprofile_visibility`
--
ALTER TABLE `hc2n_bb_xprofile_visibility`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_activity`
--
ALTER TABLE `hc2n_bp_activity`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_activity_meta`
--
ALTER TABLE `hc2n_bp_activity_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_document`
--
ALTER TABLE `hc2n_bp_document`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_document_folder`
--
ALTER TABLE `hc2n_bp_document_folder`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_document_folder_meta`
--
ALTER TABLE `hc2n_bp_document_folder_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_document_meta`
--
ALTER TABLE `hc2n_bp_document_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_follow`
--
ALTER TABLE `hc2n_bp_follow`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_friends`
--
ALTER TABLE `hc2n_bp_friends`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_groups`
--
ALTER TABLE `hc2n_bp_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_groups_groupmeta`
--
ALTER TABLE `hc2n_bp_groups_groupmeta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_groups_membermeta`
--
ALTER TABLE `hc2n_bp_groups_membermeta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_groups_members`
--
ALTER TABLE `hc2n_bp_groups_members`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_invitations`
--
ALTER TABLE `hc2n_bp_invitations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_invitations_invitemeta`
--
ALTER TABLE `hc2n_bp_invitations_invitemeta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_media`
--
ALTER TABLE `hc2n_bp_media`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_media_albums`
--
ALTER TABLE `hc2n_bp_media_albums`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_messages_messages`
--
ALTER TABLE `hc2n_bp_messages_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_messages_meta`
--
ALTER TABLE `hc2n_bp_messages_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_messages_notices`
--
ALTER TABLE `hc2n_bp_messages_notices`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_messages_recipients`
--
ALTER TABLE `hc2n_bp_messages_recipients`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_moderation`
--
ALTER TABLE `hc2n_bp_moderation`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_moderation_meta`
--
ALTER TABLE `hc2n_bp_moderation_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_notifications`
--
ALTER TABLE `hc2n_bp_notifications`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_notifications_meta`
--
ALTER TABLE `hc2n_bp_notifications_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_optouts`
--
ALTER TABLE `hc2n_bp_optouts`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_suspend`
--
ALTER TABLE `hc2n_bp_suspend`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_suspend_details`
--
ALTER TABLE `hc2n_bp_suspend_details`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_suspend_meta`
--
ALTER TABLE `hc2n_bp_suspend_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_xprofile_data`
--
ALTER TABLE `hc2n_bp_xprofile_data`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_xprofile_fields`
--
ALTER TABLE `hc2n_bp_xprofile_fields`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_xprofile_groups`
--
ALTER TABLE `hc2n_bp_xprofile_groups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_xprofile_meta`
--
ALTER TABLE `hc2n_bp_xprofile_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_zoom_meetings`
--
ALTER TABLE `hc2n_bp_zoom_meetings`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_zoom_meeting_meta`
--
ALTER TABLE `hc2n_bp_zoom_meeting_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_zoom_recordings`
--
ALTER TABLE `hc2n_bp_zoom_recordings`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_zoom_webinars`
--
ALTER TABLE `hc2n_bp_zoom_webinars`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_zoom_webinar_meta`
--
ALTER TABLE `hc2n_bp_zoom_webinar_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_bp_zoom_webinar_recordings`
--
ALTER TABLE `hc2n_bp_zoom_webinar_recordings`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_commentmeta`
--
ALTER TABLE `hc2n_commentmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_comments`
--
ALTER TABLE `hc2n_comments`
  MODIFY `comment_ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_e_events`
--
ALTER TABLE `hc2n_e_events`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_e_notes`
--
ALTER TABLE `hc2n_e_notes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_e_notes_users_relations`
--
ALTER TABLE `hc2n_e_notes_users_relations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_e_submissions`
--
ALTER TABLE `hc2n_e_submissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_e_submissions_actions_log`
--
ALTER TABLE `hc2n_e_submissions_actions_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_e_submissions_values`
--
ALTER TABLE `hc2n_e_submissions_values`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_facetwp_cache`
--
ALTER TABLE `hc2n_facetwp_cache`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_facetwp_index`
--
ALTER TABLE `hc2n_facetwp_index`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_gf_addon_feed`
--
ALTER TABLE `hc2n_gf_addon_feed`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_gf_addon_payment_callback`
--
ALTER TABLE `hc2n_gf_addon_payment_callback`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_gf_addon_payment_transaction`
--
ALTER TABLE `hc2n_gf_addon_payment_transaction`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_gf_entry`
--
ALTER TABLE `hc2n_gf_entry`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_gf_entry_meta`
--
ALTER TABLE `hc2n_gf_entry_meta`
  MODIFY `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_gf_entry_notes`
--
ALTER TABLE `hc2n_gf_entry_notes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_gf_form`
--
ALTER TABLE `hc2n_gf_form`
  MODIFY `id` mediumint(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_gf_form_revisions`
--
ALTER TABLE `hc2n_gf_form_revisions`
  MODIFY `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_gf_form_view`
--
ALTER TABLE `hc2n_gf_form_view`
  MODIFY `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_gf_rest_api_keys`
--
ALTER TABLE `hc2n_gf_rest_api_keys`
  MODIFY `key_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_links`
--
ALTER TABLE `hc2n_links`
  MODIFY `link_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_options`
--
ALTER TABLE `hc2n_options`
  MODIFY `option_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_pmxi_files`
--
ALTER TABLE `hc2n_pmxi_files`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_pmxi_geocoding`
--
ALTER TABLE `hc2n_pmxi_geocoding`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_pmxi_history`
--
ALTER TABLE `hc2n_pmxi_history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_pmxi_images`
--
ALTER TABLE `hc2n_pmxi_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_pmxi_imports`
--
ALTER TABLE `hc2n_pmxi_imports`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_pmxi_posts`
--
ALTER TABLE `hc2n_pmxi_posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_pmxi_templates`
--
ALTER TABLE `hc2n_pmxi_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_postmeta`
--
ALTER TABLE `hc2n_postmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_posts`
--
ALTER TABLE `hc2n_posts`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_post_smtp_logmeta`
--
ALTER TABLE `hc2n_post_smtp_logmeta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_post_smtp_logs`
--
ALTER TABLE `hc2n_post_smtp_logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_pronamic_pay_mollie_customers`
--
ALTER TABLE `hc2n_pronamic_pay_mollie_customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_pronamic_pay_mollie_customer_users`
--
ALTER TABLE `hc2n_pronamic_pay_mollie_customer_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_pronamic_pay_mollie_organizations`
--
ALTER TABLE `hc2n_pronamic_pay_mollie_organizations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_pronamic_pay_mollie_profiles`
--
ALTER TABLE `hc2n_pronamic_pay_mollie_profiles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_redirection_404`
--
ALTER TABLE `hc2n_redirection_404`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_redirection_groups`
--
ALTER TABLE `hc2n_redirection_groups`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_redirection_items`
--
ALTER TABLE `hc2n_redirection_items`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_redirection_logs`
--
ALTER TABLE `hc2n_redirection_logs`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_rtwapwcm_mlm`
--
ALTER TABLE `hc2n_rtwapwcm_mlm`
  MODIFY `id` mediumint(9) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_rtwapwcm_referrals`
--
ALTER TABLE `hc2n_rtwapwcm_referrals`
  MODIFY `id` mediumint(9) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_rtwapwcm_referral_link`
--
ALTER TABLE `hc2n_rtwapwcm_referral_link`
  MODIFY `id` mediumint(9) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_rtwapwcm_visitors_track`
--
ALTER TABLE `hc2n_rtwapwcm_visitors_track`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_rtwapwcm_wallet_transaction`
--
ALTER TABLE `hc2n_rtwapwcm_wallet_transaction`
  MODIFY `id` mediumint(9) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_signups`
--
ALTER TABLE `hc2n_signups`
  MODIFY `signup_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_termmeta`
--
ALTER TABLE `hc2n_termmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_terms`
--
ALTER TABLE `hc2n_terms`
  MODIFY `term_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_term_taxonomy`
--
ALTER TABLE `hc2n_term_taxonomy`
  MODIFY `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_uap_action_log`
--
ALTER TABLE `hc2n_uap_action_log`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_uap_action_log_meta`
--
ALTER TABLE `hc2n_uap_action_log_meta`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_uap_api_log`
--
ALTER TABLE `hc2n_uap_api_log`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_uap_closure_log`
--
ALTER TABLE `hc2n_uap_closure_log`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_uap_closure_log_meta`
--
ALTER TABLE `hc2n_uap_closure_log_meta`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_uap_recipe_log`
--
ALTER TABLE `hc2n_uap_recipe_log`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_uap_trigger_log`
--
ALTER TABLE `hc2n_uap_trigger_log`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_uap_trigger_log_meta`
--
ALTER TABLE `hc2n_uap_trigger_log_meta`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_umbrella_backup`
--
ALTER TABLE `hc2n_umbrella_backup`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_umbrella_log`
--
ALTER TABLE `hc2n_umbrella_log`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_umbrella_task_backup`
--
ALTER TABLE `hc2n_umbrella_task_backup`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_usermeta`
--
ALTER TABLE `hc2n_usermeta`
  MODIFY `umeta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_users`
--
ALTER TABLE `hc2n_users`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wc_admin_notes`
--
ALTER TABLE `hc2n_wc_admin_notes`
  MODIFY `note_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wc_admin_note_actions`
--
ALTER TABLE `hc2n_wc_admin_note_actions`
  MODIFY `action_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wc_customer_lookup`
--
ALTER TABLE `hc2n_wc_customer_lookup`
  MODIFY `customer_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wc_download_log`
--
ALTER TABLE `hc2n_wc_download_log`
  MODIFY `download_log_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wc_orders_meta`
--
ALTER TABLE `hc2n_wc_orders_meta`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wc_order_addresses`
--
ALTER TABLE `hc2n_wc_order_addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wc_order_operational_data`
--
ALTER TABLE `hc2n_wc_order_operational_data`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wc_product_download_directories`
--
ALTER TABLE `hc2n_wc_product_download_directories`
  MODIFY `url_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wc_rate_limits`
--
ALTER TABLE `hc2n_wc_rate_limits`
  MODIFY `rate_limit_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wc_tax_rate_classes`
--
ALTER TABLE `hc2n_wc_tax_rate_classes`
  MODIFY `tax_rate_class_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wc_webhooks`
--
ALTER TABLE `hc2n_wc_webhooks`
  MODIFY `webhook_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wfauditevents`
--
ALTER TABLE `hc2n_wfauditevents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wfblocks7`
--
ALTER TABLE `hc2n_wfblocks7`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wfhits`
--
ALTER TABLE `hc2n_wfhits`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wfhoover`
--
ALTER TABLE `hc2n_wfhoover`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wfissues`
--
ALTER TABLE `hc2n_wfissues`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wfknownfilelist`
--
ALTER TABLE `hc2n_wfknownfilelist`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wflogins`
--
ALTER TABLE `hc2n_wflogins`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wfls_2fa_secrets`
--
ALTER TABLE `hc2n_wfls_2fa_secrets`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wfpendingissues`
--
ALTER TABLE `hc2n_wfpendingissues`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wfsecurityevents`
--
ALTER TABLE `hc2n_wfsecurityevents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wfsnipcache`
--
ALTER TABLE `hc2n_wfsnipcache`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wfstatus`
--
ALTER TABLE `hc2n_wfstatus`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wfwaffailures`
--
ALTER TABLE `hc2n_wfwaffailures`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_woocommerce_api_keys`
--
ALTER TABLE `hc2n_woocommerce_api_keys`
  MODIFY `key_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_woocommerce_attribute_taxonomies`
--
ALTER TABLE `hc2n_woocommerce_attribute_taxonomies`
  MODIFY `attribute_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_woocommerce_downloadable_product_permissions`
--
ALTER TABLE `hc2n_woocommerce_downloadable_product_permissions`
  MODIFY `permission_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_woocommerce_log`
--
ALTER TABLE `hc2n_woocommerce_log`
  MODIFY `log_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_woocommerce_order_itemmeta`
--
ALTER TABLE `hc2n_woocommerce_order_itemmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_woocommerce_order_items`
--
ALTER TABLE `hc2n_woocommerce_order_items`
  MODIFY `order_item_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_woocommerce_payment_tokenmeta`
--
ALTER TABLE `hc2n_woocommerce_payment_tokenmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_woocommerce_payment_tokens`
--
ALTER TABLE `hc2n_woocommerce_payment_tokens`
  MODIFY `token_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_woocommerce_sessions`
--
ALTER TABLE `hc2n_woocommerce_sessions`
  MODIFY `session_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_woocommerce_shipping_zones`
--
ALTER TABLE `hc2n_woocommerce_shipping_zones`
  MODIFY `zone_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_woocommerce_shipping_zone_locations`
--
ALTER TABLE `hc2n_woocommerce_shipping_zone_locations`
  MODIFY `location_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_woocommerce_shipping_zone_methods`
--
ALTER TABLE `hc2n_woocommerce_shipping_zone_methods`
  MODIFY `instance_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_woocommerce_tax_rates`
--
ALTER TABLE `hc2n_woocommerce_tax_rates`
  MODIFY `tax_rate_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_woocommerce_tax_rate_locations`
--
ALTER TABLE `hc2n_woocommerce_tax_rate_locations`
  MODIFY `location_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wpmailsmtp_debug_events`
--
ALTER TABLE `hc2n_wpmailsmtp_debug_events`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wpmailsmtp_tasks_meta`
--
ALTER TABLE `hc2n_wpmailsmtp_tasks_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wpr_above_the_fold`
--
ALTER TABLE `hc2n_wpr_above_the_fold`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wpr_lazy_render_content`
--
ALTER TABLE `hc2n_wpr_lazy_render_content`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wpr_preconnect_external_domains`
--
ALTER TABLE `hc2n_wpr_preconnect_external_domains`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wpr_preload_fonts`
--
ALTER TABLE `hc2n_wpr_preload_fonts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wpr_rocket_cache`
--
ALTER TABLE `hc2n_wpr_rocket_cache`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wpr_rucss_used_css`
--
ALTER TABLE `hc2n_wpr_rucss_used_css`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wsal_metadata`
--
ALTER TABLE `hc2n_wsal_metadata`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_wsal_occurrences`
--
ALTER TABLE `hc2n_wsal_occurrences`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_yoast_indexable`
--
ALTER TABLE `hc2n_yoast_indexable`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_yoast_migrations`
--
ALTER TABLE `hc2n_yoast_migrations`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_yoast_primary_term`
--
ALTER TABLE `hc2n_yoast_primary_term`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hc2n_yoast_seo_links`
--
ALTER TABLE `hc2n_yoast_seo_links`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `chili_vqfg1`
--
CREATE DATABASE IF NOT EXISTS `chili_vqfg1` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `chili_vqfg1`;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_actionscheduler_actions`
--

CREATE TABLE `tukk_actionscheduler_actions` (
  `action_id` bigint(20) UNSIGNED NOT NULL,
  `hook` varchar(191) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `scheduled_date_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  `scheduled_date_local` datetime DEFAULT '0000-00-00 00:00:00',
  `args` varchar(191) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `schedule` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `group_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `attempts` int(11) NOT NULL DEFAULT 0,
  `last_attempt_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  `last_attempt_local` datetime DEFAULT '0000-00-00 00:00:00',
  `claim_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `extended_args` varchar(8000) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `priority` tinyint(3) UNSIGNED NOT NULL DEFAULT 10
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_actionscheduler_claims`
--

CREATE TABLE `tukk_actionscheduler_claims` (
  `claim_id` bigint(20) UNSIGNED NOT NULL,
  `date_created_gmt` datetime DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_actionscheduler_groups`
--

CREATE TABLE `tukk_actionscheduler_groups` (
  `group_id` bigint(20) UNSIGNED NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_actionscheduler_logs`
--

CREATE TABLE `tukk_actionscheduler_logs` (
  `log_id` bigint(20) UNSIGNED NOT NULL,
  `action_id` bigint(20) UNSIGNED NOT NULL,
  `message` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `log_date_gmt` datetime DEFAULT '0000-00-00 00:00:00',
  `log_date_local` datetime DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_affiliate_wp_affiliatemeta`
--

CREATE TABLE `tukk_affiliate_wp_affiliatemeta` (
  `meta_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL DEFAULT 0,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_affiliate_wp_affiliates`
--

CREATE TABLE `tukk_affiliate_wp_affiliates` (
  `affiliate_id` bigint(20) NOT NULL,
  `rest_id` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `rate` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate_type` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `flat_rate_basis` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_email` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `earnings` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `unpaid_earnings` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `referrals` bigint(20) NOT NULL,
  `visits` bigint(20) NOT NULL,
  `date_registered` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_affiliate_wp_campaigns`
--

CREATE TABLE `tukk_affiliate_wp_campaigns` (
  `campaign_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL,
  `campaign` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `visits` bigint(20) NOT NULL,
  `unique_visits` bigint(20) NOT NULL,
  `referrals` bigint(20) NOT NULL,
  `conversion_rate` float NOT NULL,
  `hash` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rest_id` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_affiliate_wp_connections`
--

CREATE TABLE `tukk_affiliate_wp_connections` (
  `connection_id` bigint(20) NOT NULL,
  `date` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `group` bigint(20) DEFAULT NULL,
  `creative` bigint(20) DEFAULT NULL,
  `affiliate` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_affiliate_wp_coupons`
--

CREATE TABLE `tukk_affiliate_wp_coupons` (
  `coupon_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL,
  `coupon_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `locked` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_affiliate_wp_creativemeta`
--

CREATE TABLE `tukk_affiliate_wp_creativemeta` (
  `meta_id` bigint(20) NOT NULL,
  `creative_id` bigint(20) NOT NULL DEFAULT 0,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_affiliate_wp_creatives`
--

CREATE TABLE `tukk_affiliate_wp_creatives` (
  `creative_id` bigint(20) NOT NULL,
  `name` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `text` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachment_id` bigint(20) NOT NULL,
  `status` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  `date_updated` datetime NOT NULL DEFAULT current_timestamp(),
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `notes` longtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_affiliate_wp_customermeta`
--

CREATE TABLE `tukk_affiliate_wp_customermeta` (
  `meta_id` bigint(20) NOT NULL,
  `affwp_customer_id` bigint(20) NOT NULL DEFAULT 0,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_affiliate_wp_customers`
--

CREATE TABLE `tukk_affiliate_wp_customers` (
  `customer_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_affiliate_wp_custom_links`
--

CREATE TABLE `tukk_affiliate_wp_custom_links` (
  `custom_link_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL,
  `link` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `campaign` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_affiliate_wp_groups`
--

CREATE TABLE `tukk_affiliate_wp_groups` (
  `group_id` bigint(20) NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta` longtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_affiliate_wp_notifications`
--

CREATE TABLE `tukk_affiliate_wp_notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `remote_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `buttons` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `type` varchar(64) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `conditions` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `dismissed` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_affiliate_wp_payouts`
--

CREATE TABLE `tukk_affiliate_wp_payouts` (
  `payout_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL,
  `referrals` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` bigint(20) NOT NULL,
  `payout_method` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_account` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_id` bigint(20) NOT NULL,
  `service_invoice_link` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_affiliate_wp_referralmeta`
--

CREATE TABLE `tukk_affiliate_wp_referralmeta` (
  `meta_id` bigint(20) NOT NULL,
  `referral_id` bigint(20) NOT NULL DEFAULT 0,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_affiliate_wp_referrals`
--

CREATE TABLE `tukk_affiliate_wp_referrals` (
  `referral_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL,
  `visit_id` bigint(20) NOT NULL,
  `rest_id` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `parent_id` bigint(20) NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency` char(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `custom` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `context` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `campaign` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `flag` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `reference` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `products` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `payout_id` bigint(20) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_affiliate_wp_rest_consumers`
--

CREATE TABLE `tukk_affiliate_wp_rest_consumers` (
  `consumer_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `token` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `public_key` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret_key` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_affiliate_wp_sales`
--

CREATE TABLE `tukk_affiliate_wp_sales` (
  `referral_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL,
  `order_total` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_affiliate_wp_visits`
--

CREATE TABLE `tukk_affiliate_wp_visits` (
  `visit_id` bigint(20) NOT NULL,
  `affiliate_id` bigint(20) NOT NULL,
  `referral_id` bigint(20) NOT NULL,
  `rest_id` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `referrer` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `campaign` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `context` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `flag` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` tinytext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_aioseo_cache`
--

CREATE TABLE `tukk_aioseo_cache` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(80) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `expiration` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_aioseo_notifications`
--

CREATE TABLE `tukk_aioseo_notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `slug` varchar(13) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `addon` varchar(64) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `type` varchar(64) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `level` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `notification_id` bigint(20) UNSIGNED DEFAULT NULL,
  `notification_name` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `button1_label` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `button1_action` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `button2_label` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `button2_action` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `dismissed` tinyint(1) NOT NULL DEFAULT 0,
  `new` tinyint(1) NOT NULL DEFAULT 1,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_aioseo_posts`
--

CREATE TABLE `tukk_aioseo_posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `keywords` mediumtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `keyphrases` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `page_analysis` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `canonical_url` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_description` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_object_type` varchar(64) COLLATE utf8mb4_unicode_520_ci DEFAULT 'default',
  `og_image_type` varchar(64) COLLATE utf8mb4_unicode_520_ci DEFAULT 'default',
  `og_image_url` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_image_width` int(11) DEFAULT NULL,
  `og_image_height` int(11) DEFAULT NULL,
  `og_image_custom_url` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_image_custom_fields` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_video` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_custom_url` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_article_section` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `og_article_tags` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_use_og` tinyint(1) DEFAULT 0,
  `twitter_card` varchar(64) COLLATE utf8mb4_unicode_520_ci DEFAULT 'default',
  `twitter_image_type` varchar(64) COLLATE utf8mb4_unicode_520_ci DEFAULT 'default',
  `twitter_image_url` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_image_custom_url` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_image_custom_fields` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_description` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `seo_score` int(11) NOT NULL DEFAULT 0,
  `schema` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `schema_type` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT 'default',
  `schema_type_options` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `pillar_content` tinyint(1) DEFAULT NULL,
  `robots_default` tinyint(1) NOT NULL DEFAULT 1,
  `robots_noindex` tinyint(1) NOT NULL DEFAULT 0,
  `robots_noarchive` tinyint(1) NOT NULL DEFAULT 0,
  `robots_nosnippet` tinyint(1) NOT NULL DEFAULT 0,
  `robots_nofollow` tinyint(1) NOT NULL DEFAULT 0,
  `robots_noimageindex` tinyint(1) NOT NULL DEFAULT 0,
  `robots_noodp` tinyint(1) NOT NULL DEFAULT 0,
  `robots_notranslate` tinyint(1) NOT NULL DEFAULT 0,
  `robots_max_snippet` int(11) DEFAULT NULL,
  `robots_max_videopreview` int(11) DEFAULT NULL,
  `robots_max_imagepreview` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT 'large',
  `images` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `image_scan_date` datetime DEFAULT NULL,
  `priority` tinytext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `frequency` tinytext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `videos` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `video_thumbnail` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `video_scan_date` datetime DEFAULT NULL,
  `local_seo` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `limit_modified_date` tinyint(1) NOT NULL DEFAULT 0,
  `options` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bb_background_job_queue`
--

CREATE TABLE `tukk_bb_background_job_queue` (
  `id` bigint(20) NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `group` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `data_id` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `secondary_data_id` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `data` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `priority` tinyint(2) DEFAULT NULL,
  `blog_id` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bb_background_process_logs`
--

CREATE TABLE `tukk_bb_background_process_logs` (
  `id` bigint(20) NOT NULL,
  `process_id` bigint(20) NOT NULL,
  `parent` bigint(20) DEFAULT NULL,
  `component` varchar(55) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `bg_process_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `bg_process_from` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `callback_function` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `blog_id` bigint(20) NOT NULL,
  `data` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `priority` bigint(10) DEFAULT NULL,
  `memory` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT '0',
  `process_start_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `process_start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `process_end_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `process_end_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bb_email_queue`
--

CREATE TABLE `tukk_bb_email_queue` (
  `id` bigint(20) NOT NULL,
  `email_type` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `recipient` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `arguments` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `scheduled` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bb_notifications_subscriptions`
--

CREATE TABLE `tukk_bb_notifications_subscriptions` (
  `id` bigint(20) NOT NULL,
  `blog_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `secondary_item_id` bigint(20) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `date_recorded` datetime DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bb_polls`
--

CREATE TABLE `tukk_bb_polls` (
  `id` bigint(20) NOT NULL,
  `item_id` bigint(20) DEFAULT 0,
  `item_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `secondary_item_id` bigint(20) DEFAULT 0,
  `user_id` bigint(20) NOT NULL,
  `question` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `settings` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `date_recorded` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `vote_disabled_date` datetime DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'draft'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bb_poll_options`
--

CREATE TABLE `tukk_bb_poll_options` (
  `id` bigint(20) NOT NULL,
  `poll_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `option_title` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `option_order` bigint(2) DEFAULT NULL,
  `date_recorded` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bb_poll_votes`
--

CREATE TABLE `tukk_bb_poll_votes` (
  `id` bigint(20) NOT NULL,
  `poll_id` bigint(20) NOT NULL,
  `option_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `date_recorded` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bb_reactions_data`
--

CREATE TABLE `tukk_bb_reactions_data` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `rel1` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `rel2` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `rel3` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bb_social_sign_on_users`
--

CREATE TABLE `tukk_bb_social_sign_on_users` (
  `id` int(11) NOT NULL,
  `wp_user_id` int(11) NOT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `identifier` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `register_date` datetime DEFAULT NULL,
  `login_date` datetime DEFAULT NULL,
  `link_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bb_user_reactions`
--

CREATE TABLE `tukk_bb_user_reactions` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `reaction_id` bigint(20) NOT NULL,
  `item_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bb_xprofile_visibility`
--

CREATE TABLE `tukk_bb_xprofile_visibility` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `field_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `value` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `last_updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_activity`
--

CREATE TABLE `tukk_bp_activity` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `component` varchar(75) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `type` varchar(75) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `action` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `primary_link` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `secondary_item_id` bigint(20) DEFAULT NULL,
  `date_recorded` datetime NOT NULL,
  `hide_sitewide` tinyint(1) DEFAULT 0,
  `mptt_left` int(11) NOT NULL DEFAULT 0,
  `mptt_right` int(11) NOT NULL DEFAULT 0,
  `is_spam` tinyint(1) NOT NULL DEFAULT 0,
  `privacy` varchar(75) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'public',
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'published'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_activity_meta`
--

CREATE TABLE `tukk_bp_activity_meta` (
  `id` bigint(20) NOT NULL,
  `activity_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_document`
--

CREATE TABLE `tukk_bp_document` (
  `id` bigint(20) NOT NULL,
  `blog_id` bigint(20) DEFAULT NULL,
  `attachment_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `folder_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `activity_id` bigint(20) DEFAULT NULL,
  `message_id` bigint(20) DEFAULT 0,
  `privacy` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT 'public',
  `menu_order` bigint(20) DEFAULT 0,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'published',
  `date_created` datetime DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_document_folder`
--

CREATE TABLE `tukk_bp_document_folder` (
  `id` bigint(20) NOT NULL,
  `blog_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `parent` bigint(20) DEFAULT 0,
  `title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `privacy` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT 'public',
  `date_created` datetime DEFAULT '0000-00-00 00:00:00',
  `date_modified` datetime DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_document_folder_meta`
--

CREATE TABLE `tukk_bp_document_folder_meta` (
  `id` bigint(20) NOT NULL,
  `folder_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_document_meta`
--

CREATE TABLE `tukk_bp_document_meta` (
  `id` bigint(20) NOT NULL,
  `document_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_follow`
--

CREATE TABLE `tukk_bp_follow` (
  `id` bigint(20) NOT NULL,
  `leader_id` bigint(20) NOT NULL,
  `follower_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_friends`
--

CREATE TABLE `tukk_bp_friends` (
  `id` bigint(20) NOT NULL,
  `initiator_user_id` bigint(20) NOT NULL,
  `friend_user_id` bigint(20) NOT NULL,
  `is_confirmed` tinyint(1) DEFAULT 0,
  `is_limited` tinyint(1) DEFAULT 0,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_groups`
--

CREATE TABLE `tukk_bp_groups` (
  `id` bigint(20) NOT NULL,
  `creator_id` bigint(20) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `slug` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `status` varchar(10) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'public',
  `parent_id` bigint(20) NOT NULL DEFAULT 0,
  `enable_forum` tinyint(1) NOT NULL DEFAULT 1,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_groups_groupmeta`
--

CREATE TABLE `tukk_bp_groups_groupmeta` (
  `id` bigint(20) NOT NULL,
  `group_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_groups_membermeta`
--

CREATE TABLE `tukk_bp_groups_membermeta` (
  `id` bigint(20) NOT NULL,
  `member_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_groups_members`
--

CREATE TABLE `tukk_bp_groups_members` (
  `id` bigint(20) NOT NULL,
  `group_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `inviter_id` bigint(20) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `is_mod` tinyint(1) NOT NULL DEFAULT 0,
  `user_title` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_modified` datetime NOT NULL,
  `comments` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `is_confirmed` tinyint(1) NOT NULL DEFAULT 0,
  `is_banned` tinyint(1) NOT NULL DEFAULT 0,
  `invite_sent` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_invitations`
--

CREATE TABLE `tukk_bp_invitations` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `inviter_id` bigint(20) NOT NULL,
  `invitee_email` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `class` varchar(120) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `secondary_item_id` bigint(20) DEFAULT NULL,
  `type` varchar(12) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'invite',
  `content` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `date_modified` datetime NOT NULL,
  `invite_sent` tinyint(1) NOT NULL DEFAULT 0,
  `accepted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_invitations_invitemeta`
--

CREATE TABLE `tukk_bp_invitations_invitemeta` (
  `id` bigint(20) NOT NULL,
  `invite_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_media`
--

CREATE TABLE `tukk_bp_media` (
  `id` bigint(20) NOT NULL,
  `blog_id` bigint(20) DEFAULT NULL,
  `attachment_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `album_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `activity_id` bigint(20) DEFAULT NULL,
  `message_id` bigint(20) DEFAULT 0,
  `privacy` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT 'public',
  `type` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT 'photo',
  `menu_order` bigint(20) DEFAULT 0,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'published',
  `date_created` datetime DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_media_albums`
--

CREATE TABLE `tukk_bp_media_albums` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT '0000-00-00 00:00:00',
  `title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `privacy` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT 'public'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_messages_messages`
--

CREATE TABLE `tukk_bp_messages_messages` (
  `id` bigint(20) NOT NULL,
  `thread_id` bigint(20) NOT NULL,
  `sender_id` bigint(20) NOT NULL,
  `subject` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_sent` datetime NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_messages_meta`
--

CREATE TABLE `tukk_bp_messages_meta` (
  `id` bigint(20) NOT NULL,
  `message_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_messages_notices`
--

CREATE TABLE `tukk_bp_messages_notices` (
  `id` bigint(20) NOT NULL,
  `subject` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_sent` datetime NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_messages_recipients`
--

CREATE TABLE `tukk_bp_messages_recipients` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `thread_id` bigint(20) NOT NULL,
  `unread_count` int(10) NOT NULL DEFAULT 0,
  `sender_only` tinyint(1) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  `is_hidden` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_moderation`
--

CREATE TABLE `tukk_bp_moderation` (
  `id` bigint(20) NOT NULL,
  `moderation_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_created` datetime DEFAULT '0000-00-00 00:00:00',
  `category_id` bigint(20) NOT NULL,
  `user_report` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_moderation_meta`
--

CREATE TABLE `tukk_bp_moderation_meta` (
  `id` bigint(20) NOT NULL,
  `moderation_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_notifications`
--

CREATE TABLE `tukk_bp_notifications` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `secondary_item_id` bigint(20) DEFAULT NULL,
  `component_name` varchar(75) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `component_action` varchar(75) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_notified` datetime NOT NULL,
  `is_new` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_notifications_meta`
--

CREATE TABLE `tukk_bp_notifications_meta` (
  `id` bigint(20) NOT NULL,
  `notification_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_optouts`
--

CREATE TABLE `tukk_bp_optouts` (
  `id` bigint(20) NOT NULL,
  `email_address_hash` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `email_type` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_suspend`
--

CREATE TABLE `tukk_bp_suspend` (
  `id` bigint(20) NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `item_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `hide_sitewide` tinyint(1) NOT NULL,
  `hide_parent` tinyint(1) NOT NULL,
  `user_suspended` tinyint(1) NOT NULL,
  `reported` tinyint(1) NOT NULL,
  `user_report` tinyint(4) DEFAULT 0,
  `last_updated` datetime DEFAULT '0000-00-00 00:00:00',
  `blog_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_suspend_details`
--

CREATE TABLE `tukk_bp_suspend_details` (
  `id` bigint(20) NOT NULL,
  `suspend_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_suspend_meta`
--

CREATE TABLE `tukk_bp_suspend_meta` (
  `id` bigint(20) NOT NULL,
  `suspend_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_xprofile_data`
--

CREATE TABLE `tukk_bp_xprofile_data` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `field_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `last_updated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_xprofile_fields`
--

CREATE TABLE `tukk_bp_xprofile_fields` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `group_id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT 0,
  `is_default_option` tinyint(1) NOT NULL DEFAULT 0,
  `field_order` bigint(20) NOT NULL DEFAULT 0,
  `option_order` bigint(20) NOT NULL DEFAULT 0,
  `order_by` varchar(15) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `can_delete` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_xprofile_groups`
--

CREATE TABLE `tukk_bp_xprofile_groups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `group_order` bigint(20) NOT NULL DEFAULT 0,
  `can_delete` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_xprofile_meta`
--

CREATE TABLE `tukk_bp_xprofile_meta` (
  `id` bigint(20) NOT NULL,
  `object_id` bigint(20) NOT NULL,
  `object_type` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_zoom_meetings`
--

CREATE TABLE `tukk_bp_zoom_meetings` (
  `id` bigint(20) NOT NULL,
  `group_id` bigint(20) NOT NULL,
  `activity_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `host_id` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `type` int(10) NOT NULL DEFAULT 2,
  `title` varchar(300) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` varchar(800) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `start_date_utc` datetime NOT NULL,
  `timezone` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `password` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `duration` int(11) NOT NULL,
  `join_before_host` tinyint(1) DEFAULT 0,
  `host_video` tinyint(1) DEFAULT 0,
  `participants_video` tinyint(1) DEFAULT 0,
  `mute_participants` tinyint(1) DEFAULT 0,
  `waiting_room` tinyint(1) DEFAULT 0,
  `meeting_authentication` tinyint(1) DEFAULT 0,
  `recurring` tinyint(1) DEFAULT 0,
  `auto_recording` varchar(75) COLLATE utf8mb4_unicode_520_ci DEFAULT 'none',
  `alternative_host_ids` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meeting_id` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `hide_sitewide` tinyint(1) DEFAULT 0,
  `parent` varchar(150) COLLATE utf8mb4_unicode_520_ci DEFAULT '0',
  `zoom_type` varchar(150) COLLATE utf8mb4_unicode_520_ci DEFAULT 'meeting',
  `alert` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_zoom_meeting_meta`
--

CREATE TABLE `tukk_bp_zoom_meeting_meta` (
  `id` bigint(20) NOT NULL,
  `meeting_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_zoom_recordings`
--

CREATE TABLE `tukk_bp_zoom_recordings` (
  `id` bigint(20) NOT NULL,
  `recording_id` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `meeting_id` bigint(20) NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `details` varchar(800) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `file_type` varchar(800) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `password` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `start_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_zoom_webinars`
--

CREATE TABLE `tukk_bp_zoom_webinars` (
  `id` bigint(20) NOT NULL,
  `group_id` bigint(20) NOT NULL,
  `activity_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `host_id` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `type` int(10) NOT NULL DEFAULT 2,
  `title` varchar(300) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `description` varchar(800) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `start_date_utc` datetime NOT NULL,
  `timezone` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `password` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `duration` int(11) NOT NULL,
  `host_video` tinyint(1) DEFAULT 0,
  `panelists_video` tinyint(1) DEFAULT 0,
  `meeting_authentication` tinyint(1) DEFAULT 0,
  `practice_session` tinyint(1) DEFAULT 0,
  `on_demand` tinyint(1) DEFAULT 0,
  `recurring` tinyint(1) DEFAULT 0,
  `auto_recording` varchar(75) COLLATE utf8mb4_unicode_520_ci DEFAULT 'none',
  `alternative_host_ids` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `webinar_id` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `hide_sitewide` tinyint(1) DEFAULT 0,
  `parent` varchar(150) COLLATE utf8mb4_unicode_520_ci DEFAULT '0',
  `zoom_type` varchar(150) COLLATE utf8mb4_unicode_520_ci DEFAULT 'webinar',
  `alert` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_zoom_webinar_meta`
--

CREATE TABLE `tukk_bp_zoom_webinar_meta` (
  `id` bigint(20) NOT NULL,
  `webinar_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_bp_zoom_webinar_recordings`
--

CREATE TABLE `tukk_bp_zoom_webinar_recordings` (
  `id` bigint(20) NOT NULL,
  `recording_id` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `webinar_id` bigint(20) NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `details` varchar(800) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `file_type` varchar(800) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `password` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `start_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_commentmeta`
--

CREATE TABLE `tukk_commentmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `comment_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_comments`
--

CREATE TABLE `tukk_comments` (
  `comment_ID` bigint(20) UNSIGNED NOT NULL,
  `comment_post_ID` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `comment_author` tinytext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_author_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_url` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_author_IP` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `comment_karma` int(11) NOT NULL DEFAULT 0,
  `comment_approved` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '1',
  `comment_agent` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'comment',
  `comment_parent` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_e_events`
--

CREATE TABLE `tukk_e_events` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `event_data` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_e_notes`
--

CREATE TABLE `tukk_e_notes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `route_url` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'Clean url where the note was created.',
  `route_title` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `route_post_id` bigint(20) UNSIGNED DEFAULT NULL COMMENT 'The post id of the route that the note was created on.',
  `post_id` bigint(20) UNSIGNED DEFAULT NULL,
  `element_id` varchar(60) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'The Elementor element ID the note is attached to.',
  `parent_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `author_id` bigint(20) UNSIGNED DEFAULT NULL,
  `author_display_name` varchar(250) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'Save the author name when the author was deleted.',
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'publish',
  `position` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL COMMENT 'A JSON string that represents the position of the note inside the element in percentages. e.g. {x:10, y:15}',
  `content` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `is_resolved` tinyint(1) NOT NULL DEFAULT 0,
  `is_public` tinyint(1) NOT NULL DEFAULT 1,
  `last_activity_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_e_notes_users_relations`
--

CREATE TABLE `tukk_e_notes_users_relations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL COMMENT 'The relation type between user and note (e.g mention, watch, read).',
  `note_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_e_submissions`
--

CREATE TABLE `tukk_e_submissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(60) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `hash_id` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `main_meta_id` bigint(20) UNSIGNED NOT NULL COMMENT 'Id of main field. to represent the main meta field',
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `referer` varchar(500) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `referer_title` varchar(300) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `element_id` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `form_name` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `campaign_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_ip` varchar(46) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `actions_count` int(11) DEFAULT 0,
  `actions_succeeded_count` int(11) DEFAULT 0,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `meta` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `created_at_gmt` datetime NOT NULL,
  `updated_at_gmt` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_e_submissions_actions_log`
--

CREATE TABLE `tukk_e_submissions_actions_log` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `submission_id` bigint(20) UNSIGNED NOT NULL,
  `action_name` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `action_label` varchar(60) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `log` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `created_at_gmt` datetime NOT NULL,
  `updated_at_gmt` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_e_submissions_values`
--

CREATE TABLE `tukk_e_submissions_values` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `submission_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `key` varchar(60) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_facetwp_index`
--

CREATE TABLE `tukk_facetwp_index` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` int(10) UNSIGNED DEFAULT NULL,
  `facet_name` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `facet_value` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `facet_display_value` varchar(200) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `term_id` int(10) UNSIGNED DEFAULT 0,
  `parent_id` int(10) UNSIGNED DEFAULT 0,
  `depth` int(10) UNSIGNED DEFAULT 0,
  `variation_id` int(10) UNSIGNED DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_gf_addon_feed`
--

CREATE TABLE `tukk_gf_addon_feed` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `form_id` mediumint(8) UNSIGNED NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `feed_order` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
  `meta` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `addon_slug` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `event_type` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_gf_addon_payment_transaction`
--

CREATE TABLE `tukk_gf_addon_payment_transaction` (
  `id` int(10) UNSIGNED NOT NULL,
  `lead_id` int(10) UNSIGNED NOT NULL,
  `transaction_type` varchar(30) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `transaction_id` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `subscription_id` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `is_recurring` tinyint(1) NOT NULL DEFAULT 0,
  `amount` decimal(19,2) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_gf_draft_submissions`
--

CREATE TABLE `tukk_gf_draft_submissions` (
  `uuid` char(32) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `form_id` mediumint(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `ip` varchar(45) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `source_url` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `submission` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_gf_entry`
--

CREATE TABLE `tukk_gf_entry` (
  `id` int(10) UNSIGNED NOT NULL,
  `form_id` mediumint(10) UNSIGNED NOT NULL,
  `post_id` bigint(10) UNSIGNED DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime DEFAULT NULL,
  `is_starred` tinyint(10) NOT NULL DEFAULT 0,
  `is_read` tinyint(10) NOT NULL DEFAULT 0,
  `ip` varchar(45) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `source_url` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_agent` varchar(250) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `currency` varchar(5) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `payment_status` varchar(15) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `payment_date` datetime DEFAULT NULL,
  `payment_amount` decimal(19,2) DEFAULT NULL,
  `payment_method` varchar(30) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `transaction_id` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `is_fulfilled` tinyint(10) DEFAULT NULL,
  `created_by` bigint(10) UNSIGNED DEFAULT NULL,
  `transaction_type` tinyint(10) DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'active',
  `source_id` bigint(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_gf_entry_meta`
--

CREATE TABLE `tukk_gf_entry_meta` (
  `id` bigint(10) UNSIGNED NOT NULL,
  `form_id` mediumint(10) UNSIGNED NOT NULL DEFAULT 0,
  `entry_id` bigint(10) UNSIGNED NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `item_index` varchar(60) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_gf_entry_notes`
--

CREATE TABLE `tukk_gf_entry_notes` (
  `id` int(10) UNSIGNED NOT NULL,
  `entry_id` int(10) UNSIGNED NOT NULL,
  `user_name` varchar(250) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `user_id` bigint(10) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `note_type` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `sub_type` varchar(50) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_gf_form`
--

CREATE TABLE `tukk_gf_form` (
  `id` mediumint(10) UNSIGNED NOT NULL,
  `title` varchar(150) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime DEFAULT NULL,
  `is_active` tinyint(10) NOT NULL DEFAULT 1,
  `is_trash` tinyint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_gf_form_meta`
--

CREATE TABLE `tukk_gf_form_meta` (
  `form_id` mediumint(10) UNSIGNED NOT NULL,
  `display_meta` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `entries_grid_meta` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `confirmations` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `notifications` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_gf_form_revisions`
--

CREATE TABLE `tukk_gf_form_revisions` (
  `id` bigint(10) UNSIGNED NOT NULL,
  `form_id` mediumint(10) UNSIGNED NOT NULL,
  `display_meta` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `date_created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_gf_form_view`
--

CREATE TABLE `tukk_gf_form_view` (
  `id` bigint(10) UNSIGNED NOT NULL,
  `form_id` mediumint(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `ip` char(15) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `count` mediumint(10) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_gf_rest_api_keys`
--

CREATE TABLE `tukk_gf_rest_api_keys` (
  `key_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `permissions` varchar(10) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `consumer_key` char(64) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `consumer_secret` char(43) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `nonces` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `truncated_key` char(7) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `last_access` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_links`
--

CREATE TABLE `tukk_links` (
  `link_id` bigint(20) UNSIGNED NOT NULL,
  `link_url` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_image` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_target` varchar(25) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_description` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_visible` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'Y',
  `link_owner` bigint(20) UNSIGNED NOT NULL DEFAULT 1,
  `link_rating` int(11) NOT NULL DEFAULT 0,
  `link_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `link_notes` mediumtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `link_rss` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_options`
--

CREATE TABLE `tukk_options` (
  `option_id` bigint(20) UNSIGNED NOT NULL,
  `option_name` varchar(191) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `option_value` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `autoload` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'yes'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_pmxi_files`
--

CREATE TABLE `tukk_pmxi_files` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `import_id` bigint(20) UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `path` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `registered_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_pmxi_geocoding`
--

CREATE TABLE `tukk_pmxi_geocoding` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `address` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `latitude` decimal(18,15) DEFAULT NULL,
  `longitude` decimal(18,15) DEFAULT NULL,
  `raw_data` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `provider` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'google_maps',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_pmxi_hash`
--

CREATE TABLE `tukk_pmxi_hash` (
  `hash` binary(16) NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `import_id` smallint(5) UNSIGNED NOT NULL,
  `post_type` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_pmxi_history`
--

CREATE TABLE `tukk_pmxi_history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `import_id` bigint(20) UNSIGNED NOT NULL,
  `type` enum('manual','processing','trigger','continue','cli','') COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `time_run` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `summary` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_pmxi_images`
--

CREATE TABLE `tukk_pmxi_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `attachment_id` bigint(20) UNSIGNED NOT NULL,
  `image_url` text COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `image_filename` text COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_pmxi_imports`
--

CREATE TABLE `tukk_pmxi_imports` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `parent_import_id` bigint(20) NOT NULL DEFAULT 0,
  `name` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `friendly_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `type` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `feed_type` enum('xml','csv','zip','gz','') COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `path` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `xpath` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `options` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `registered_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `root_element` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `processing` tinyint(1) NOT NULL DEFAULT 0,
  `executing` tinyint(1) NOT NULL DEFAULT 0,
  `triggered` tinyint(1) NOT NULL DEFAULT 0,
  `queue_chunk_number` bigint(20) NOT NULL DEFAULT 0,
  `first_import` timestamp NOT NULL DEFAULT current_timestamp(),
  `count` bigint(20) NOT NULL DEFAULT 0,
  `imported` bigint(20) NOT NULL DEFAULT 0,
  `created` bigint(20) NOT NULL DEFAULT 0,
  `updated` bigint(20) NOT NULL DEFAULT 0,
  `skipped` bigint(20) NOT NULL DEFAULT 0,
  `deleted` bigint(20) NOT NULL DEFAULT 0,
  `canceled` tinyint(1) NOT NULL DEFAULT 0,
  `canceled_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `failed` tinyint(1) NOT NULL DEFAULT 0,
  `failed_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `settings_update_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_activity` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `iteration` bigint(20) NOT NULL DEFAULT 0,
  `changed_missing` bigint(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_pmxi_posts`
--

CREATE TABLE `tukk_pmxi_posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `import_id` bigint(20) UNSIGNED NOT NULL,
  `unique_key` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `product_key` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `iteration` bigint(20) NOT NULL DEFAULT 0,
  `specified` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_pmxi_templates`
--

CREATE TABLE `tukk_pmxi_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `options` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `scheduled` varchar(64) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `is_keep_linebreaks` tinyint(1) NOT NULL DEFAULT 0,
  `is_leave_html` tinyint(1) NOT NULL DEFAULT 0,
  `fix_characters` tinyint(1) NOT NULL DEFAULT 0,
  `meta` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_postmeta`
--

CREATE TABLE `tukk_postmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_posts`
--

CREATE TABLE `tukk_posts` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `post_author` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_title` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_excerpt` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'open',
  `post_password` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `post_name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `to_ping` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `pinged` text COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `post_parent` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `guid` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `menu_order` int(11) NOT NULL DEFAULT 0,
  `post_type` varchar(20) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `comment_count` bigint(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_post_smtp_logmeta`
--

CREATE TABLE `tukk_post_smtp_logmeta` (
  `id` bigint(20) NOT NULL,
  `log_id` bigint(20) NOT NULL,
  `meta_key` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_post_smtp_logs`
--

CREATE TABLE `tukk_post_smtp_logs` (
  `id` bigint(20) NOT NULL,
  `solution` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `success` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `from_header` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `to_header` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `cc_header` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `bcc_header` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `reply_to_header` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `transport_uri` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `original_to` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `original_subject` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `original_message` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `original_headers` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `session_transcript` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `time` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_pronamic_pay_mollie_customers`
--

CREATE TABLE `tukk_pronamic_pay_mollie_customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `mollie_id` varchar(16) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `organization_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_id` bigint(20) UNSIGNED DEFAULT NULL,
  `test_mode` tinyint(1) NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_pronamic_pay_mollie_customer_users`
--

CREATE TABLE `tukk_pronamic_pay_mollie_customer_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_pronamic_pay_mollie_organizations`
--

CREATE TABLE `tukk_pronamic_pay_mollie_organizations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `mollie_id` varchar(16) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `name` varchar(128) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_pronamic_pay_mollie_profiles`
--

CREATE TABLE `tukk_pronamic_pay_mollie_profiles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `mollie_id` varchar(16) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `organization_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(128) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `api_key_test` varchar(35) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `api_key_live` varchar(35) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_rp4wp_cache`
--

CREATE TABLE `tukk_rp4wp_cache` (
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `word` varchar(255) NOT NULL,
  `weight` float UNSIGNED NOT NULL,
  `post_type` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_signups`
--

CREATE TABLE `tukk_signups` (
  `signup_id` bigint(20) NOT NULL,
  `domain` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `path` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `title` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `user_login` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `activated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active` tinyint(1) NOT NULL DEFAULT 0,
  `activation_key` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `meta` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_termmeta`
--

CREATE TABLE `tukk_termmeta` (
  `meta_id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_terms`
--

CREATE TABLE `tukk_terms` (
  `term_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `slug` varchar(200) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `term_group` bigint(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_term_relationships`
--

CREATE TABLE `tukk_term_relationships` (
  `object_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `term_order` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_term_taxonomy`
--

CREATE TABLE `tukk_term_taxonomy` (
  `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL,
  `term_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `taxonomy` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `description` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `parent` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `count` bigint(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_uap_action_log`
--

CREATE TABLE `tukk_uap_action_log` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `date_time` timestamp NULL DEFAULT current_timestamp(),
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `automator_action_id` bigint(20) UNSIGNED NOT NULL,
  `automator_recipe_id` bigint(20) UNSIGNED NOT NULL,
  `automator_recipe_log_id` bigint(20) UNSIGNED DEFAULT NULL,
  `completed` tinyint(1) UNSIGNED NOT NULL,
  `error_message` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_uap_action_log_meta`
--

CREATE TABLE `tukk_uap_action_log_meta` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `automator_action_log_id` bigint(20) UNSIGNED DEFAULT NULL,
  `automator_action_id` bigint(20) UNSIGNED NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_uap_api_log`
--

CREATE TABLE `tukk_uap_api_log` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `date_time` timestamp NULL DEFAULT current_timestamp(),
  `type` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `recipe_log_id` bigint(20) UNSIGNED NOT NULL,
  `item_log_id` bigint(20) UNSIGNED NOT NULL,
  `endpoint` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `params` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `request` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `response` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `price` bigint(20) UNSIGNED DEFAULT NULL,
  `balance` bigint(20) UNSIGNED DEFAULT NULL,
  `time_spent` bigint(20) UNSIGNED DEFAULT NULL,
  `notes` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_uap_closure_log`
--

CREATE TABLE `tukk_uap_closure_log` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `date_time` timestamp NULL DEFAULT current_timestamp(),
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `automator_closure_id` bigint(20) UNSIGNED NOT NULL,
  `automator_recipe_id` bigint(20) UNSIGNED NOT NULL,
  `automator_recipe_log_id` bigint(20) UNSIGNED NOT NULL,
  `completed` tinyint(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_uap_closure_log_meta`
--

CREATE TABLE `tukk_uap_closure_log_meta` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `automator_closure_id` bigint(20) UNSIGNED NOT NULL,
  `automator_closure_log_id` bigint(20) UNSIGNED NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_uap_recipe_log`
--

CREATE TABLE `tukk_uap_recipe_log` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `date_time` timestamp NULL DEFAULT current_timestamp(),
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `automator_recipe_id` bigint(20) UNSIGNED NOT NULL,
  `completed` tinyint(1) NOT NULL,
  `run_number` mediumint(8) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_uap_trigger_log`
--

CREATE TABLE `tukk_uap_trigger_log` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `date_time` timestamp NULL DEFAULT current_timestamp(),
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `automator_trigger_id` bigint(20) UNSIGNED NOT NULL,
  `automator_recipe_id` bigint(20) UNSIGNED NOT NULL,
  `automator_recipe_log_id` bigint(20) UNSIGNED DEFAULT NULL,
  `completed` tinyint(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_uap_trigger_log_meta`
--

CREATE TABLE `tukk_uap_trigger_log_meta` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `automator_trigger_log_id` bigint(20) UNSIGNED DEFAULT NULL,
  `automator_trigger_id` bigint(20) UNSIGNED NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `run_number` mediumint(8) UNSIGNED NOT NULL DEFAULT 1,
  `run_time` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_usermeta`
--

CREATE TABLE `tukk_usermeta` (
  `umeta_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `meta_value` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_users`
--

CREATE TABLE `tukk_users` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `user_login` varchar(60) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_pass` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_nicename` varchar(50) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_email` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_url` varchar(100) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `user_status` int(11) NOT NULL DEFAULT 0,
  `display_name` varchar(250) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_wpmailsmtp_debug_events`
--

CREATE TABLE `tukk_wpmailsmtp_debug_events` (
  `id` int(10) UNSIGNED NOT NULL,
  `content` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `initiator` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `event_type` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_wpmailsmtp_tasks_meta`
--

CREATE TABLE `tukk_wpmailsmtp_tasks_meta` (
  `id` bigint(20) NOT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `data` longtext COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_wpr_above_the_fold`
--

CREATE TABLE `tukk_wpr_above_the_fold` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(2000) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `is_mobile` tinyint(1) NOT NULL DEFAULT 0,
  `lcp` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `viewport` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `error_message` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_accessed` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_wpr_lazy_render_content`
--

CREATE TABLE `tukk_wpr_lazy_render_content` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(2000) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `is_mobile` tinyint(1) NOT NULL DEFAULT 0,
  `below_the_fold` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `error_message` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `status` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_accessed` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_wpr_rocket_cache`
--

CREATE TABLE `tukk_wpr_rocket_cache` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(2000) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `status` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_accessed` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_locked` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_wpr_rucss_used_css`
--

CREATE TABLE `tukk_wpr_rucss_used_css` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(2000) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `css` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `hash` varchar(32) COLLATE utf8mb4_unicode_520_ci DEFAULT '',
  `error_code` varchar(32) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `error_message` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `unprocessedcss` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `retries` tinyint(1) NOT NULL DEFAULT 1,
  `is_mobile` tinyint(1) NOT NULL DEFAULT 0,
  `job_id` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `queue_name` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `status` varchar(255) COLLATE utf8mb4_unicode_520_ci NOT NULL DEFAULT '',
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_accessed` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `submitted_at` timestamp NULL DEFAULT NULL,
  `next_retry_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_yoast_indexable`
--

CREATE TABLE `tukk_yoast_indexable` (
  `id` int(11) UNSIGNED NOT NULL,
  `permalink` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `permalink_hash` varchar(40) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `object_id` bigint(20) DEFAULT NULL,
  `object_type` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `object_sub_type` varchar(32) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `author_id` bigint(20) DEFAULT NULL,
  `post_parent` bigint(20) DEFAULT NULL,
  `title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `breadcrumb_title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `post_status` varchar(20) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT NULL,
  `is_protected` tinyint(1) DEFAULT 0,
  `has_public_posts` tinyint(1) DEFAULT NULL,
  `number_of_pages` int(11) UNSIGNED DEFAULT NULL,
  `canonical` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `primary_focus_keyword` varchar(191) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `primary_focus_keyword_score` int(3) DEFAULT NULL,
  `readability_score` int(3) DEFAULT NULL,
  `is_cornerstone` tinyint(1) DEFAULT 0,
  `is_robots_noindex` tinyint(1) DEFAULT 0,
  `is_robots_nofollow` tinyint(1) DEFAULT 0,
  `is_robots_noarchive` tinyint(1) DEFAULT 0,
  `is_robots_noimageindex` tinyint(1) DEFAULT 0,
  `is_robots_nosnippet` tinyint(1) DEFAULT 0,
  `twitter_title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_image` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_description` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_image_id` varchar(191) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `twitter_image_source` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `open_graph_title` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `open_graph_description` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `open_graph_image` longtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `open_graph_image_id` varchar(191) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `open_graph_image_source` text COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `open_graph_image_meta` mediumtext COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `link_count` int(11) DEFAULT NULL,
  `incoming_link_count` int(11) DEFAULT NULL,
  `prominent_words_version` int(11) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `blog_id` bigint(20) NOT NULL DEFAULT 1,
  `language` varchar(32) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `region` varchar(32) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `schema_page_type` varchar(64) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `schema_article_type` varchar(64) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL,
  `has_ancestors` tinyint(1) DEFAULT 0,
  `estimated_reading_time_minutes` int(11) DEFAULT NULL,
  `version` int(11) DEFAULT 1,
  `object_last_modified` datetime DEFAULT NULL,
  `object_published_at` datetime DEFAULT NULL,
  `inclusive_language_score` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_yoast_indexable_hierarchy`
--

CREATE TABLE `tukk_yoast_indexable_hierarchy` (
  `indexable_id` int(11) UNSIGNED NOT NULL,
  `ancestor_id` int(11) UNSIGNED NOT NULL,
  `depth` int(11) UNSIGNED DEFAULT NULL,
  `blog_id` bigint(20) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_yoast_migrations`
--

CREATE TABLE `tukk_yoast_migrations` (
  `id` int(11) UNSIGNED NOT NULL,
  `version` varchar(191) COLLATE utf8mb4_unicode_520_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_yoast_primary_term`
--

CREATE TABLE `tukk_yoast_primary_term` (
  `id` int(11) UNSIGNED NOT NULL,
  `post_id` bigint(20) DEFAULT NULL,
  `term_id` bigint(20) DEFAULT NULL,
  `taxonomy` varchar(32) COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `blog_id` bigint(20) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tukk_yoast_seo_links`
--

CREATE TABLE `tukk_yoast_seo_links` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `post_id` bigint(20) UNSIGNED DEFAULT NULL,
  `target_post_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` varchar(8) DEFAULT NULL,
  `indexable_id` int(11) UNSIGNED DEFAULT NULL,
  `target_indexable_id` int(11) UNSIGNED DEFAULT NULL,
  `height` int(11) UNSIGNED DEFAULT NULL,
  `width` int(11) UNSIGNED DEFAULT NULL,
  `size` int(11) UNSIGNED DEFAULT NULL,
  `language` varchar(32) DEFAULT NULL,
  `region` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tukk_actionscheduler_actions`
--
ALTER TABLE `tukk_actionscheduler_actions`
  ADD PRIMARY KEY (`action_id`),
  ADD KEY `hook` (`hook`),
  ADD KEY `status` (`status`),
  ADD KEY `scheduled_date_gmt` (`scheduled_date_gmt`),
  ADD KEY `args` (`args`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `last_attempt_gmt` (`last_attempt_gmt`),
  ADD KEY `claim_id_status_scheduled_date_gmt` (`claim_id`,`status`,`scheduled_date_gmt`),
  ADD KEY `hook_status_scheduled_date_gmt` (`hook`(163),`status`,`scheduled_date_gmt`),
  ADD KEY `status_scheduled_date_gmt` (`status`,`scheduled_date_gmt`);

--
-- Indexes for table `tukk_actionscheduler_claims`
--
ALTER TABLE `tukk_actionscheduler_claims`
  ADD PRIMARY KEY (`claim_id`),
  ADD KEY `date_created_gmt` (`date_created_gmt`);

--
-- Indexes for table `tukk_actionscheduler_groups`
--
ALTER TABLE `tukk_actionscheduler_groups`
  ADD PRIMARY KEY (`group_id`),
  ADD KEY `slug` (`slug`(191));

--
-- Indexes for table `tukk_actionscheduler_logs`
--
ALTER TABLE `tukk_actionscheduler_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `action_id` (`action_id`),
  ADD KEY `log_date_gmt` (`log_date_gmt`);

--
-- Indexes for table `tukk_affiliate_wp_affiliatemeta`
--
ALTER TABLE `tukk_affiliate_wp_affiliatemeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `affiliate_id` (`affiliate_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `tukk_affiliate_wp_affiliates`
--
ALTER TABLE `tukk_affiliate_wp_affiliates`
  ADD PRIMARY KEY (`affiliate_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tukk_affiliate_wp_campaigns`
--
ALTER TABLE `tukk_affiliate_wp_campaigns`
  ADD PRIMARY KEY (`campaign_id`),
  ADD KEY `affiliate_id` (`affiliate_id`),
  ADD KEY `hash` (`hash`);

--
-- Indexes for table `tukk_affiliate_wp_connections`
--
ALTER TABLE `tukk_affiliate_wp_connections`
  ADD PRIMARY KEY (`connection_id`);

--
-- Indexes for table `tukk_affiliate_wp_coupons`
--
ALTER TABLE `tukk_affiliate_wp_coupons`
  ADD PRIMARY KEY (`coupon_id`),
  ADD KEY `coupon_code` (`coupon_code`);

--
-- Indexes for table `tukk_affiliate_wp_creativemeta`
--
ALTER TABLE `tukk_affiliate_wp_creativemeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `creative_id` (`creative_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `tukk_affiliate_wp_creatives`
--
ALTER TABLE `tukk_affiliate_wp_creatives`
  ADD PRIMARY KEY (`creative_id`),
  ADD KEY `creative_id` (`creative_id`);

--
-- Indexes for table `tukk_affiliate_wp_customermeta`
--
ALTER TABLE `tukk_affiliate_wp_customermeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `affwp_customer_id` (`affwp_customer_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `tukk_affiliate_wp_customers`
--
ALTER TABLE `tukk_affiliate_wp_customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `tukk_affiliate_wp_custom_links`
--
ALTER TABLE `tukk_affiliate_wp_custom_links`
  ADD PRIMARY KEY (`custom_link_id`),
  ADD KEY `custom_link_id` (`custom_link_id`);

--
-- Indexes for table `tukk_affiliate_wp_groups`
--
ALTER TABLE `tukk_affiliate_wp_groups`
  ADD PRIMARY KEY (`group_id`);

--
-- Indexes for table `tukk_affiliate_wp_notifications`
--
ALTER TABLE `tukk_affiliate_wp_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dismissed_start_end` (`dismissed`,`start`,`end`);

--
-- Indexes for table `tukk_affiliate_wp_payouts`
--
ALTER TABLE `tukk_affiliate_wp_payouts`
  ADD PRIMARY KEY (`payout_id`),
  ADD KEY `affiliate_id` (`affiliate_id`),
  ADD KEY `service_id` (`service_id`);

--
-- Indexes for table `tukk_affiliate_wp_referralmeta`
--
ALTER TABLE `tukk_affiliate_wp_referralmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `referral_id` (`referral_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `tukk_affiliate_wp_referrals`
--
ALTER TABLE `tukk_affiliate_wp_referrals`
  ADD PRIMARY KEY (`referral_id`),
  ADD KEY `affiliate_id` (`affiliate_id`);

--
-- Indexes for table `tukk_affiliate_wp_rest_consumers`
--
ALTER TABLE `tukk_affiliate_wp_rest_consumers`
  ADD PRIMARY KEY (`consumer_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tukk_affiliate_wp_sales`
--
ALTER TABLE `tukk_affiliate_wp_sales`
  ADD PRIMARY KEY (`referral_id`),
  ADD KEY `affiliate_id` (`affiliate_id`);

--
-- Indexes for table `tukk_affiliate_wp_visits`
--
ALTER TABLE `tukk_affiliate_wp_visits`
  ADD PRIMARY KEY (`visit_id`),
  ADD KEY `affiliate_id` (`affiliate_id`);

--
-- Indexes for table `tukk_aioseo_cache`
--
ALTER TABLE `tukk_aioseo_cache`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ndx_aioseo_cache_key` (`key`),
  ADD KEY `ndx_aioseo_cache_expiration` (`expiration`);

--
-- Indexes for table `tukk_aioseo_notifications`
--
ALTER TABLE `tukk_aioseo_notifications`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ndx_aioseo_notifications_slug` (`slug`),
  ADD KEY `ndx_aioseo_notifications_dates` (`start`,`end`),
  ADD KEY `ndx_aioseo_notifications_type` (`type`),
  ADD KEY `ndx_aioseo_notifications_dismissed` (`dismissed`);

--
-- Indexes for table `tukk_aioseo_posts`
--
ALTER TABLE `tukk_aioseo_posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ndx_aioseo_posts_post_id` (`post_id`);

--
-- Indexes for table `tukk_bb_background_job_queue`
--
ALTER TABLE `tukk_bb_background_job_queue`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type` (`type`),
  ADD KEY `group` (`group`),
  ADD KEY `data_id` (`data_id`),
  ADD KEY `secondary_data_id` (`secondary_data_id`),
  ADD KEY `priority` (`priority`),
  ADD KEY `blog_id` (`blog_id`),
  ADD KEY `date_created` (`date_created`);

--
-- Indexes for table `tukk_bb_background_process_logs`
--
ALTER TABLE `tukk_bb_background_process_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `process_start_date_gmt` (`process_start_date_gmt`);

--
-- Indexes for table `tukk_bb_email_queue`
--
ALTER TABLE `tukk_bb_email_queue`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tukk_bb_notifications_subscriptions`
--
ALTER TABLE `tukk_bb_notifications_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blog_id` (`blog_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `type` (`type`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `secondary_item_id` (`secondary_item_id`),
  ADD KEY `status` (`status`),
  ADD KEY `date_recorded` (`date_recorded`);

--
-- Indexes for table `tukk_bb_polls`
--
ALTER TABLE `tukk_bb_polls`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `item_type` (`item_type`),
  ADD KEY `secondary_item_id` (`secondary_item_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `date_recorded` (`date_recorded`),
  ADD KEY `date_updated` (`date_updated`),
  ADD KEY `status` (`status`);

--
-- Indexes for table `tukk_bb_poll_options`
--
ALTER TABLE `tukk_bb_poll_options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `poll_id` (`poll_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `option_title` (`option_title`),
  ADD KEY `option_order` (`option_order`),
  ADD KEY `date_recorded` (`date_recorded`),
  ADD KEY `date_updated` (`date_updated`);

--
-- Indexes for table `tukk_bb_poll_votes`
--
ALTER TABLE `tukk_bb_poll_votes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `poll_id` (`poll_id`),
  ADD KEY `option_id` (`option_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `date_recorded` (`date_recorded`);

--
-- Indexes for table `tukk_bb_reactions_data`
--
ALTER TABLE `tukk_bb_reactions_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`),
  ADD KEY `rel1` (`rel1`),
  ADD KEY `rel2` (`rel2`),
  ADD KEY `rel3` (`rel3`),
  ADD KEY `date` (`date`);

--
-- Indexes for table `tukk_bb_social_sign_on_users`
--
ALTER TABLE `tukk_bb_social_sign_on_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wp_user_id` (`wp_user_id`,`type`),
  ADD KEY `identifier` (`identifier`);

--
-- Indexes for table `tukk_bb_user_reactions`
--
ALTER TABLE `tukk_bb_user_reactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `reaction_id` (`reaction_id`),
  ADD KEY `item_type` (`item_type`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `date_created` (`date_created`);

--
-- Indexes for table `tukk_bb_xprofile_visibility`
--
ALTER TABLE `tukk_bb_xprofile_visibility`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_field_id_user_id` (`field_id`,`user_id`),
  ADD KEY `field_id` (`field_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `value` (`value`);

--
-- Indexes for table `tukk_bp_activity`
--
ALTER TABLE `tukk_bp_activity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `date_recorded` (`date_recorded`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `secondary_item_id` (`secondary_item_id`),
  ADD KEY `component` (`component`),
  ADD KEY `type` (`type`),
  ADD KEY `mptt_left` (`mptt_left`),
  ADD KEY `mptt_right` (`mptt_right`),
  ADD KEY `hide_sitewide` (`hide_sitewide`),
  ADD KEY `is_spam` (`is_spam`);

--
-- Indexes for table `tukk_bp_activity_meta`
--
ALTER TABLE `tukk_bp_activity_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `activity_id` (`activity_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `tukk_bp_document`
--
ALTER TABLE `tukk_bp_document`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attachment_id` (`attachment_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `folder_id` (`folder_id`),
  ADD KEY `document_author_id` (`folder_id`,`user_id`),
  ADD KEY `activity_id` (`activity_id`),
  ADD KEY `blog_id` (`blog_id`),
  ADD KEY `message_id` (`message_id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `privacy` (`privacy`),
  ADD KEY `menu_order` (`menu_order`),
  ADD KEY `date_created` (`date_created`),
  ADD KEY `date_modified` (`date_modified`),
  ADD KEY `blog_id_2` (`blog_id`),
  ADD KEY `message_id_2` (`message_id`),
  ADD KEY `group_id_2` (`group_id`),
  ADD KEY `privacy_2` (`privacy`),
  ADD KEY `menu_order_2` (`menu_order`),
  ADD KEY `date_created_2` (`date_created`),
  ADD KEY `date_modified_2` (`date_modified`);

--
-- Indexes for table `tukk_bp_document_folder`
--
ALTER TABLE `tukk_bp_document_folder`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tukk_bp_document_folder_meta`
--
ALTER TABLE `tukk_bp_document_folder_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `folder_id` (`folder_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `tukk_bp_document_meta`
--
ALTER TABLE `tukk_bp_document_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `document_id` (`document_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `tukk_bp_follow`
--
ALTER TABLE `tukk_bp_follow`
  ADD PRIMARY KEY (`id`),
  ADD KEY `followers` (`leader_id`,`follower_id`);

--
-- Indexes for table `tukk_bp_friends`
--
ALTER TABLE `tukk_bp_friends`
  ADD PRIMARY KEY (`id`),
  ADD KEY `initiator_user_id` (`initiator_user_id`),
  ADD KEY `friend_user_id` (`friend_user_id`);

--
-- Indexes for table `tukk_bp_groups`
--
ALTER TABLE `tukk_bp_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `creator_id` (`creator_id`),
  ADD KEY `status` (`status`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `tukk_bp_groups_groupmeta`
--
ALTER TABLE `tukk_bp_groups_groupmeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `tukk_bp_groups_membermeta`
--
ALTER TABLE `tukk_bp_groups_membermeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_id` (`member_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `tukk_bp_groups_members`
--
ALTER TABLE `tukk_bp_groups_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `is_admin` (`is_admin`),
  ADD KEY `is_mod` (`is_mod`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `inviter_id` (`inviter_id`),
  ADD KEY `is_confirmed` (`is_confirmed`);

--
-- Indexes for table `tukk_bp_invitations`
--
ALTER TABLE `tukk_bp_invitations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `inviter_id` (`inviter_id`),
  ADD KEY `invitee_email` (`invitee_email`),
  ADD KEY `class` (`class`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `secondary_item_id` (`secondary_item_id`),
  ADD KEY `type` (`type`),
  ADD KEY `invite_sent` (`invite_sent`),
  ADD KEY `accepted` (`accepted`);

--
-- Indexes for table `tukk_bp_invitations_invitemeta`
--
ALTER TABLE `tukk_bp_invitations_invitemeta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invite_id` (`invite_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `tukk_bp_media`
--
ALTER TABLE `tukk_bp_media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attachment_id` (`attachment_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `album_id` (`album_id`),
  ADD KEY `media_author_id` (`album_id`,`user_id`),
  ADD KEY `activity_id` (`activity_id`),
  ADD KEY `blog_id` (`blog_id`),
  ADD KEY `message_id` (`message_id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `privacy` (`privacy`),
  ADD KEY `type` (`type`),
  ADD KEY `menu_order` (`menu_order`),
  ADD KEY `date_created` (`date_created`),
  ADD KEY `blog_id_2` (`blog_id`),
  ADD KEY `message_id_2` (`message_id`),
  ADD KEY `group_id_2` (`group_id`),
  ADD KEY `privacy_2` (`privacy`),
  ADD KEY `type_2` (`type`),
  ADD KEY `menu_order_2` (`menu_order`),
  ADD KEY `date_created_2` (`date_created`);

--
-- Indexes for table `tukk_bp_media_albums`
--
ALTER TABLE `tukk_bp_media_albums`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tukk_bp_messages_messages`
--
ALTER TABLE `tukk_bp_messages_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `thread_id` (`thread_id`);

--
-- Indexes for table `tukk_bp_messages_meta`
--
ALTER TABLE `tukk_bp_messages_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `message_id` (`message_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `tukk_bp_messages_notices`
--
ALTER TABLE `tukk_bp_messages_notices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `is_active` (`is_active`);

--
-- Indexes for table `tukk_bp_messages_recipients`
--
ALTER TABLE `tukk_bp_messages_recipients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `thread_id` (`thread_id`),
  ADD KEY `is_deleted` (`is_deleted`),
  ADD KEY `sender_only` (`sender_only`),
  ADD KEY `unread_count` (`unread_count`),
  ADD KEY `is_hidden` (`is_hidden`);

--
-- Indexes for table `tukk_bp_moderation`
--
ALTER TABLE `tukk_bp_moderation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `moderation_report_id` (`moderation_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tukk_bp_moderation_meta`
--
ALTER TABLE `tukk_bp_moderation_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `moderation_id` (`moderation_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `tukk_bp_notifications`
--
ALTER TABLE `tukk_bp_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `secondary_item_id` (`secondary_item_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `is_new` (`is_new`),
  ADD KEY `component_name` (`component_name`),
  ADD KEY `component_action` (`component_action`),
  ADD KEY `useritem` (`user_id`,`is_new`);

--
-- Indexes for table `tukk_bp_notifications_meta`
--
ALTER TABLE `tukk_bp_notifications_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notification_id` (`notification_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `tukk_bp_optouts`
--
ALTER TABLE `tukk_bp_optouts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `email_type` (`email_type`),
  ADD KEY `date_modified` (`date_modified`);

--
-- Indexes for table `tukk_bp_suspend`
--
ALTER TABLE `tukk_bp_suspend`
  ADD PRIMARY KEY (`id`),
  ADD KEY `suspend_item_id` (`item_id`,`item_type`,`blog_id`),
  ADD KEY `suspend_item` (`item_id`,`item_type`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `user_suspended` (`user_suspended`),
  ADD KEY `hide_parent` (`hide_parent`),
  ADD KEY `hide_sitewide` (`hide_sitewide`),
  ADD KEY `suspend_conditions` (`user_suspended`,`hide_parent`,`hide_sitewide`);

--
-- Indexes for table `tukk_bp_suspend_details`
--
ALTER TABLE `tukk_bp_suspend_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `suspend_details_id` (`suspend_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tukk_bp_suspend_meta`
--
ALTER TABLE `tukk_bp_suspend_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `suspend_id` (`suspend_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `tukk_bp_xprofile_data`
--
ALTER TABLE `tukk_bp_xprofile_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `field_id` (`field_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tukk_bp_xprofile_fields`
--
ALTER TABLE `tukk_bp_xprofile_fields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `field_order` (`field_order`),
  ADD KEY `can_delete` (`can_delete`),
  ADD KEY `is_required` (`is_required`);

--
-- Indexes for table `tukk_bp_xprofile_groups`
--
ALTER TABLE `tukk_bp_xprofile_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `can_delete` (`can_delete`);

--
-- Indexes for table `tukk_bp_xprofile_meta`
--
ALTER TABLE `tukk_bp_xprofile_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `object_id` (`object_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `tukk_bp_zoom_meetings`
--
ALTER TABLE `tukk_bp_zoom_meetings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `activity_id` (`activity_id`),
  ADD KEY `meeting_id` (`meeting_id`);

--
-- Indexes for table `tukk_bp_zoom_meeting_meta`
--
ALTER TABLE `tukk_bp_zoom_meeting_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meeting_id` (`meeting_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `tukk_bp_zoom_recordings`
--
ALTER TABLE `tukk_bp_zoom_recordings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recording_id` (`recording_id`),
  ADD KEY `meeting_id` (`meeting_id`);

--
-- Indexes for table `tukk_bp_zoom_webinars`
--
ALTER TABLE `tukk_bp_zoom_webinars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `activity_id` (`activity_id`),
  ADD KEY `webinar_id` (`webinar_id`);

--
-- Indexes for table `tukk_bp_zoom_webinar_meta`
--
ALTER TABLE `tukk_bp_zoom_webinar_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `webinar_id` (`webinar_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `tukk_bp_zoom_webinar_recordings`
--
ALTER TABLE `tukk_bp_zoom_webinar_recordings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recording_id` (`recording_id`),
  ADD KEY `webinar_id` (`webinar_id`);

--
-- Indexes for table `tukk_commentmeta`
--
ALTER TABLE `tukk_commentmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `comment_id` (`comment_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `tukk_comments`
--
ALTER TABLE `tukk_comments`
  ADD PRIMARY KEY (`comment_ID`),
  ADD KEY `comment_post_ID` (`comment_post_ID`),
  ADD KEY `comment_approved_date_gmt` (`comment_approved`,`comment_date_gmt`),
  ADD KEY `comment_date_gmt` (`comment_date_gmt`),
  ADD KEY `comment_parent` (`comment_parent`),
  ADD KEY `comment_author_email` (`comment_author_email`(10));

--
-- Indexes for table `tukk_e_events`
--
ALTER TABLE `tukk_e_events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_at_index` (`created_at`);

--
-- Indexes for table `tukk_e_notes`
--
ALTER TABLE `tukk_e_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `route_url_index` (`route_url`(191)),
  ADD KEY `post_id_index` (`post_id`),
  ADD KEY `element_id_index` (`element_id`),
  ADD KEY `parent_id_index` (`parent_id`),
  ADD KEY `author_id_index` (`author_id`),
  ADD KEY `status_index` (`status`),
  ADD KEY `is_resolved_index` (`is_resolved`),
  ADD KEY `is_public_index` (`is_public`),
  ADD KEY `created_at_index` (`created_at`),
  ADD KEY `updated_at_index` (`updated_at`),
  ADD KEY `last_activity_at_index` (`last_activity_at`);

--
-- Indexes for table `tukk_e_notes_users_relations`
--
ALTER TABLE `tukk_e_notes_users_relations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type_index` (`type`),
  ADD KEY `note_id_index` (`note_id`),
  ADD KEY `user_id_index` (`user_id`);

--
-- Indexes for table `tukk_e_submissions`
--
ALTER TABLE `tukk_e_submissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `hash_id_unique_index` (`hash_id`),
  ADD KEY `main_meta_id_index` (`main_meta_id`),
  ADD KEY `hash_id_index` (`hash_id`),
  ADD KEY `type_index` (`type`),
  ADD KEY `post_id_index` (`post_id`),
  ADD KEY `element_id_index` (`element_id`),
  ADD KEY `campaign_id_index` (`campaign_id`),
  ADD KEY `user_id_index` (`user_id`),
  ADD KEY `user_ip_index` (`user_ip`),
  ADD KEY `status_index` (`status`),
  ADD KEY `is_read_index` (`is_read`),
  ADD KEY `created_at_gmt_index` (`created_at_gmt`),
  ADD KEY `updated_at_gmt_index` (`updated_at_gmt`),
  ADD KEY `created_at_index` (`created_at`),
  ADD KEY `updated_at_index` (`updated_at`),
  ADD KEY `referer_index` (`referer`(191)),
  ADD KEY `referer_title_index` (`referer_title`(191));

--
-- Indexes for table `tukk_e_submissions_actions_log`
--
ALTER TABLE `tukk_e_submissions_actions_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submission_id_index` (`submission_id`),
  ADD KEY `action_name_index` (`action_name`),
  ADD KEY `status_index` (`status`),
  ADD KEY `created_at_gmt_index` (`created_at_gmt`),
  ADD KEY `updated_at_gmt_index` (`updated_at_gmt`),
  ADD KEY `created_at_index` (`created_at`),
  ADD KEY `updated_at_index` (`updated_at`);

--
-- Indexes for table `tukk_e_submissions_values`
--
ALTER TABLE `tukk_e_submissions_values`
  ADD PRIMARY KEY (`id`),
  ADD KEY `submission_id_index` (`submission_id`),
  ADD KEY `key_index` (`key`);

--
-- Indexes for table `tukk_facetwp_index`
--
ALTER TABLE `tukk_facetwp_index`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id_idx` (`post_id`),
  ADD KEY `facet_name_idx` (`facet_name`),
  ADD KEY `facet_name_value_idx` (`facet_name`,`facet_value`);

--
-- Indexes for table `tukk_gf_addon_feed`
--
ALTER TABLE `tukk_gf_addon_feed`
  ADD PRIMARY KEY (`id`),
  ADD KEY `addon_form` (`addon_slug`,`form_id`);

--
-- Indexes for table `tukk_gf_addon_payment_transaction`
--
ALTER TABLE `tukk_gf_addon_payment_transaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lead_id` (`lead_id`),
  ADD KEY `transaction_type` (`transaction_type`),
  ADD KEY `type_lead` (`lead_id`,`transaction_type`);

--
-- Indexes for table `tukk_gf_draft_submissions`
--
ALTER TABLE `tukk_gf_draft_submissions`
  ADD PRIMARY KEY (`uuid`),
  ADD KEY `form_id` (`form_id`);

--
-- Indexes for table `tukk_gf_entry`
--
ALTER TABLE `tukk_gf_entry`
  ADD PRIMARY KEY (`id`),
  ADD KEY `form_id` (`form_id`),
  ADD KEY `form_id_status` (`form_id`,`status`);

--
-- Indexes for table `tukk_gf_entry_meta`
--
ALTER TABLE `tukk_gf_entry_meta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meta_key` (`meta_key`(191)),
  ADD KEY `entry_id` (`entry_id`),
  ADD KEY `meta_value` (`meta_value`(191));

--
-- Indexes for table `tukk_gf_entry_notes`
--
ALTER TABLE `tukk_gf_entry_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `entry_id` (`entry_id`),
  ADD KEY `entry_user_key` (`entry_id`,`user_id`);

--
-- Indexes for table `tukk_gf_form`
--
ALTER TABLE `tukk_gf_form`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tukk_gf_form_meta`
--
ALTER TABLE `tukk_gf_form_meta`
  ADD PRIMARY KEY (`form_id`);

--
-- Indexes for table `tukk_gf_form_revisions`
--
ALTER TABLE `tukk_gf_form_revisions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `date_created` (`date_created`),
  ADD KEY `form_id` (`form_id`);

--
-- Indexes for table `tukk_gf_form_view`
--
ALTER TABLE `tukk_gf_form_view`
  ADD PRIMARY KEY (`id`),
  ADD KEY `date_created` (`date_created`),
  ADD KEY `form_id` (`form_id`);

--
-- Indexes for table `tukk_gf_rest_api_keys`
--
ALTER TABLE `tukk_gf_rest_api_keys`
  ADD PRIMARY KEY (`key_id`),
  ADD KEY `consumer_key` (`consumer_key`),
  ADD KEY `consumer_secret` (`consumer_secret`);

--
-- Indexes for table `tukk_links`
--
ALTER TABLE `tukk_links`
  ADD PRIMARY KEY (`link_id`),
  ADD KEY `link_visible` (`link_visible`);

--
-- Indexes for table `tukk_options`
--
ALTER TABLE `tukk_options`
  ADD PRIMARY KEY (`option_id`),
  ADD UNIQUE KEY `option_name` (`option_name`),
  ADD KEY `autoload` (`autoload`);

--
-- Indexes for table `tukk_pmxi_files`
--
ALTER TABLE `tukk_pmxi_files`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tukk_pmxi_geocoding`
--
ALTER TABLE `tukk_pmxi_geocoding`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_address` (`address`(255)),
  ADD KEY `idx_coordinates` (`latitude`,`longitude`);

--
-- Indexes for table `tukk_pmxi_hash`
--
ALTER TABLE `tukk_pmxi_hash`
  ADD PRIMARY KEY (`hash`);

--
-- Indexes for table `tukk_pmxi_history`
--
ALTER TABLE `tukk_pmxi_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tukk_pmxi_images`
--
ALTER TABLE `tukk_pmxi_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tukk_pmxi_imports`
--
ALTER TABLE `tukk_pmxi_imports`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tukk_pmxi_posts`
--
ALTER TABLE `tukk_pmxi_posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tukk_pmxi_templates`
--
ALTER TABLE `tukk_pmxi_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tukk_postmeta`
--
ALTER TABLE `tukk_postmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `tukk_posts`
--
ALTER TABLE `tukk_posts`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `post_name` (`post_name`(191)),
  ADD KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  ADD KEY `post_parent` (`post_parent`),
  ADD KEY `post_author` (`post_author`);
ALTER TABLE `tukk_posts` ADD FULLTEXT KEY `crp_related` (`post_title`,`post_content`);
ALTER TABLE `tukk_posts` ADD FULLTEXT KEY `crp_related_title` (`post_title`);
ALTER TABLE `tukk_posts` ADD FULLTEXT KEY `crp_related_content` (`post_content`);

--
-- Indexes for table `tukk_post_smtp_logmeta`
--
ALTER TABLE `tukk_post_smtp_logmeta`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tukk_post_smtp_logs`
--
ALTER TABLE `tukk_post_smtp_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tukk_pronamic_pay_mollie_customers`
--
ALTER TABLE `tukk_pronamic_pay_mollie_customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mollie_id` (`mollie_id`),
  ADD KEY `organization_id` (`organization_id`),
  ADD KEY `profile_id` (`profile_id`),
  ADD KEY `test_mode` (`test_mode`),
  ADD KEY `email` (`email`);

--
-- Indexes for table `tukk_pronamic_pay_mollie_customer_users`
--
ALTER TABLE `tukk_pronamic_pay_mollie_customer_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customer_user` (`customer_id`,`user_id`),
  ADD KEY `fk_customer_user_id` (`user_id`);

--
-- Indexes for table `tukk_pronamic_pay_mollie_organizations`
--
ALTER TABLE `tukk_pronamic_pay_mollie_organizations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mollie_id` (`mollie_id`);

--
-- Indexes for table `tukk_pronamic_pay_mollie_profiles`
--
ALTER TABLE `tukk_pronamic_pay_mollie_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `mollie_id` (`mollie_id`),
  ADD KEY `organization_id` (`organization_id`);

--
-- Indexes for table `tukk_rp4wp_cache`
--
ALTER TABLE `tukk_rp4wp_cache`
  ADD PRIMARY KEY (`post_id`,`word`);

--
-- Indexes for table `tukk_signups`
--
ALTER TABLE `tukk_signups`
  ADD PRIMARY KEY (`signup_id`),
  ADD KEY `activation_key` (`activation_key`),
  ADD KEY `user_email` (`user_email`),
  ADD KEY `user_login_email` (`user_login`,`user_email`),
  ADD KEY `domain_path` (`domain`(140),`path`(51));

--
-- Indexes for table `tukk_termmeta`
--
ALTER TABLE `tukk_termmeta`
  ADD PRIMARY KEY (`meta_id`),
  ADD KEY `term_id` (`term_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `tukk_terms`
--
ALTER TABLE `tukk_terms`
  ADD PRIMARY KEY (`term_id`),
  ADD KEY `slug` (`slug`(191)),
  ADD KEY `name` (`name`(191));

--
-- Indexes for table `tukk_term_relationships`
--
ALTER TABLE `tukk_term_relationships`
  ADD PRIMARY KEY (`object_id`,`term_taxonomy_id`),
  ADD KEY `term_taxonomy_id` (`term_taxonomy_id`);

--
-- Indexes for table `tukk_term_taxonomy`
--
ALTER TABLE `tukk_term_taxonomy`
  ADD PRIMARY KEY (`term_taxonomy_id`),
  ADD UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  ADD KEY `taxonomy` (`taxonomy`);

--
-- Indexes for table `tukk_uap_action_log`
--
ALTER TABLE `tukk_uap_action_log`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `completed` (`completed`),
  ADD KEY `automator_action_id` (`automator_action_id`),
  ADD KEY `automator_recipe_log_id` (`automator_recipe_log_id`),
  ADD KEY `automator_recipe_id` (`automator_recipe_id`);

--
-- Indexes for table `tukk_uap_action_log_meta`
--
ALTER TABLE `tukk_uap_action_log_meta`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `automator_action_log_id` (`automator_action_log_id`),
  ADD KEY `automator_action_id` (`automator_action_id`),
  ADD KEY `meta_key` (`meta_key`(20));

--
-- Indexes for table `tukk_uap_api_log`
--
ALTER TABLE `tukk_uap_api_log`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `item_log_id` (`item_log_id`);

--
-- Indexes for table `tukk_uap_closure_log`
--
ALTER TABLE `tukk_uap_closure_log`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `automator_recipe_id` (`automator_recipe_id`),
  ADD KEY `automator_closure_id` (`automator_closure_id`),
  ADD KEY `completed` (`completed`);

--
-- Indexes for table `tukk_uap_closure_log_meta`
--
ALTER TABLE `tukk_uap_closure_log_meta`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `automator_closure_id` (`automator_closure_id`),
  ADD KEY `meta_key` (`meta_key`(15));

--
-- Indexes for table `tukk_uap_recipe_log`
--
ALTER TABLE `tukk_uap_recipe_log`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `completed` (`completed`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `automator_recipe_id` (`automator_recipe_id`);

--
-- Indexes for table `tukk_uap_trigger_log`
--
ALTER TABLE `tukk_uap_trigger_log`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `completed` (`completed`),
  ADD KEY `automator_recipe_id` (`automator_recipe_id`),
  ADD KEY `automator_trigger_id` (`automator_trigger_id`),
  ADD KEY `automator_recipe_log_id` (`automator_recipe_log_id`);

--
-- Indexes for table `tukk_uap_trigger_log_meta`
--
ALTER TABLE `tukk_uap_trigger_log_meta`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `run_number` (`run_number`),
  ADD KEY `automator_trigger_id` (`automator_trigger_id`),
  ADD KEY `automator_trigger_log_id` (`automator_trigger_log_id`),
  ADD KEY `meta_key` (`meta_key`(20));

--
-- Indexes for table `tukk_usermeta`
--
ALTER TABLE `tukk_usermeta`
  ADD PRIMARY KEY (`umeta_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `meta_key` (`meta_key`(191));

--
-- Indexes for table `tukk_users`
--
ALTER TABLE `tukk_users`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_login_key` (`user_login`),
  ADD KEY `user_nicename` (`user_nicename`),
  ADD KEY `user_email` (`user_email`);

--
-- Indexes for table `tukk_wpmailsmtp_debug_events`
--
ALTER TABLE `tukk_wpmailsmtp_debug_events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tukk_wpmailsmtp_tasks_meta`
--
ALTER TABLE `tukk_wpmailsmtp_tasks_meta`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tukk_wpr_above_the_fold`
--
ALTER TABLE `tukk_wpr_above_the_fold`
  ADD PRIMARY KEY (`id`),
  ADD KEY `url` (`url`(150),`is_mobile`),
  ADD KEY `modified` (`modified`),
  ADD KEY `last_accessed` (`last_accessed`),
  ADD KEY `status_index` (`status`(191));

--
-- Indexes for table `tukk_wpr_lazy_render_content`
--
ALTER TABLE `tukk_wpr_lazy_render_content`
  ADD PRIMARY KEY (`id`),
  ADD KEY `url` (`url`(150),`is_mobile`),
  ADD KEY `modified` (`modified`),
  ADD KEY `last_accessed` (`last_accessed`),
  ADD KEY `status_index` (`status`(191));

--
-- Indexes for table `tukk_wpr_rocket_cache`
--
ALTER TABLE `tukk_wpr_rocket_cache`
  ADD PRIMARY KEY (`id`),
  ADD KEY `url` (`url`(191)),
  ADD KEY `modified` (`modified`),
  ADD KEY `last_accessed` (`last_accessed`);

--
-- Indexes for table `tukk_wpr_rucss_used_css`
--
ALTER TABLE `tukk_wpr_rucss_used_css`
  ADD PRIMARY KEY (`id`),
  ADD KEY `url` (`url`(150),`is_mobile`),
  ADD KEY `modified` (`modified`),
  ADD KEY `last_accessed` (`last_accessed`),
  ADD KEY `status_index` (`status`(191)),
  ADD KEY `error_code_index` (`error_code`),
  ADD KEY `hash` (`hash`);

--
-- Indexes for table `tukk_yoast_indexable`
--
ALTER TABLE `tukk_yoast_indexable`
  ADD PRIMARY KEY (`id`),
  ADD KEY `object_type_and_sub_type` (`object_type`,`object_sub_type`),
  ADD KEY `object_id_and_type` (`object_id`,`object_type`),
  ADD KEY `permalink_hash_and_object_type` (`permalink_hash`,`object_type`),
  ADD KEY `subpages` (`post_parent`,`object_type`,`post_status`,`object_id`),
  ADD KEY `prominent_words` (`prominent_words_version`,`object_type`,`object_sub_type`,`post_status`),
  ADD KEY `published_sitemap_index` (`object_published_at`,`is_robots_noindex`,`object_type`,`object_sub_type`);

--
-- Indexes for table `tukk_yoast_indexable_hierarchy`
--
ALTER TABLE `tukk_yoast_indexable_hierarchy`
  ADD PRIMARY KEY (`indexable_id`,`ancestor_id`),
  ADD KEY `indexable_id` (`indexable_id`),
  ADD KEY `ancestor_id` (`ancestor_id`),
  ADD KEY `depth` (`depth`);

--
-- Indexes for table `tukk_yoast_migrations`
--
ALTER TABLE `tukk_yoast_migrations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `fngs_yoast_migrations_version` (`version`);

--
-- Indexes for table `tukk_yoast_primary_term`
--
ALTER TABLE `tukk_yoast_primary_term`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_taxonomy` (`post_id`,`taxonomy`),
  ADD KEY `post_term` (`post_id`,`term_id`);

--
-- Indexes for table `tukk_yoast_seo_links`
--
ALTER TABLE `tukk_yoast_seo_links`
  ADD PRIMARY KEY (`id`),
  ADD KEY `link_direction` (`post_id`,`type`),
  ADD KEY `indexable_link_direction` (`indexable_id`,`type`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tukk_actionscheduler_actions`
--
ALTER TABLE `tukk_actionscheduler_actions`
  MODIFY `action_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_actionscheduler_claims`
--
ALTER TABLE `tukk_actionscheduler_claims`
  MODIFY `claim_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_actionscheduler_groups`
--
ALTER TABLE `tukk_actionscheduler_groups`
  MODIFY `group_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_actionscheduler_logs`
--
ALTER TABLE `tukk_actionscheduler_logs`
  MODIFY `log_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_affiliate_wp_affiliatemeta`
--
ALTER TABLE `tukk_affiliate_wp_affiliatemeta`
  MODIFY `meta_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_affiliate_wp_affiliates`
--
ALTER TABLE `tukk_affiliate_wp_affiliates`
  MODIFY `affiliate_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_affiliate_wp_campaigns`
--
ALTER TABLE `tukk_affiliate_wp_campaigns`
  MODIFY `campaign_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_affiliate_wp_connections`
--
ALTER TABLE `tukk_affiliate_wp_connections`
  MODIFY `connection_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_affiliate_wp_coupons`
--
ALTER TABLE `tukk_affiliate_wp_coupons`
  MODIFY `coupon_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_affiliate_wp_creativemeta`
--
ALTER TABLE `tukk_affiliate_wp_creativemeta`
  MODIFY `meta_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_affiliate_wp_creatives`
--
ALTER TABLE `tukk_affiliate_wp_creatives`
  MODIFY `creative_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_affiliate_wp_customermeta`
--
ALTER TABLE `tukk_affiliate_wp_customermeta`
  MODIFY `meta_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_affiliate_wp_customers`
--
ALTER TABLE `tukk_affiliate_wp_customers`
  MODIFY `customer_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_affiliate_wp_custom_links`
--
ALTER TABLE `tukk_affiliate_wp_custom_links`
  MODIFY `custom_link_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_affiliate_wp_groups`
--
ALTER TABLE `tukk_affiliate_wp_groups`
  MODIFY `group_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_affiliate_wp_notifications`
--
ALTER TABLE `tukk_affiliate_wp_notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_affiliate_wp_payouts`
--
ALTER TABLE `tukk_affiliate_wp_payouts`
  MODIFY `payout_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_affiliate_wp_referralmeta`
--
ALTER TABLE `tukk_affiliate_wp_referralmeta`
  MODIFY `meta_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_affiliate_wp_referrals`
--
ALTER TABLE `tukk_affiliate_wp_referrals`
  MODIFY `referral_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_affiliate_wp_rest_consumers`
--
ALTER TABLE `tukk_affiliate_wp_rest_consumers`
  MODIFY `consumer_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_affiliate_wp_visits`
--
ALTER TABLE `tukk_affiliate_wp_visits`
  MODIFY `visit_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_aioseo_cache`
--
ALTER TABLE `tukk_aioseo_cache`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_aioseo_notifications`
--
ALTER TABLE `tukk_aioseo_notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_aioseo_posts`
--
ALTER TABLE `tukk_aioseo_posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bb_background_job_queue`
--
ALTER TABLE `tukk_bb_background_job_queue`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bb_background_process_logs`
--
ALTER TABLE `tukk_bb_background_process_logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bb_email_queue`
--
ALTER TABLE `tukk_bb_email_queue`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bb_notifications_subscriptions`
--
ALTER TABLE `tukk_bb_notifications_subscriptions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bb_polls`
--
ALTER TABLE `tukk_bb_polls`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bb_poll_options`
--
ALTER TABLE `tukk_bb_poll_options`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bb_poll_votes`
--
ALTER TABLE `tukk_bb_poll_votes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bb_reactions_data`
--
ALTER TABLE `tukk_bb_reactions_data`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bb_social_sign_on_users`
--
ALTER TABLE `tukk_bb_social_sign_on_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bb_user_reactions`
--
ALTER TABLE `tukk_bb_user_reactions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bb_xprofile_visibility`
--
ALTER TABLE `tukk_bb_xprofile_visibility`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_activity`
--
ALTER TABLE `tukk_bp_activity`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_activity_meta`
--
ALTER TABLE `tukk_bp_activity_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_document`
--
ALTER TABLE `tukk_bp_document`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_document_folder`
--
ALTER TABLE `tukk_bp_document_folder`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_document_folder_meta`
--
ALTER TABLE `tukk_bp_document_folder_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_document_meta`
--
ALTER TABLE `tukk_bp_document_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_follow`
--
ALTER TABLE `tukk_bp_follow`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_friends`
--
ALTER TABLE `tukk_bp_friends`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_groups`
--
ALTER TABLE `tukk_bp_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_groups_groupmeta`
--
ALTER TABLE `tukk_bp_groups_groupmeta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_groups_membermeta`
--
ALTER TABLE `tukk_bp_groups_membermeta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_groups_members`
--
ALTER TABLE `tukk_bp_groups_members`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_invitations`
--
ALTER TABLE `tukk_bp_invitations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_invitations_invitemeta`
--
ALTER TABLE `tukk_bp_invitations_invitemeta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_media`
--
ALTER TABLE `tukk_bp_media`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_media_albums`
--
ALTER TABLE `tukk_bp_media_albums`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_messages_messages`
--
ALTER TABLE `tukk_bp_messages_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_messages_meta`
--
ALTER TABLE `tukk_bp_messages_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_messages_notices`
--
ALTER TABLE `tukk_bp_messages_notices`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_messages_recipients`
--
ALTER TABLE `tukk_bp_messages_recipients`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_moderation`
--
ALTER TABLE `tukk_bp_moderation`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_moderation_meta`
--
ALTER TABLE `tukk_bp_moderation_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_notifications`
--
ALTER TABLE `tukk_bp_notifications`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_notifications_meta`
--
ALTER TABLE `tukk_bp_notifications_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_optouts`
--
ALTER TABLE `tukk_bp_optouts`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_suspend`
--
ALTER TABLE `tukk_bp_suspend`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_suspend_details`
--
ALTER TABLE `tukk_bp_suspend_details`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_suspend_meta`
--
ALTER TABLE `tukk_bp_suspend_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_xprofile_data`
--
ALTER TABLE `tukk_bp_xprofile_data`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_xprofile_fields`
--
ALTER TABLE `tukk_bp_xprofile_fields`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_xprofile_groups`
--
ALTER TABLE `tukk_bp_xprofile_groups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_xprofile_meta`
--
ALTER TABLE `tukk_bp_xprofile_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_zoom_meetings`
--
ALTER TABLE `tukk_bp_zoom_meetings`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_zoom_meeting_meta`
--
ALTER TABLE `tukk_bp_zoom_meeting_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_zoom_recordings`
--
ALTER TABLE `tukk_bp_zoom_recordings`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_zoom_webinars`
--
ALTER TABLE `tukk_bp_zoom_webinars`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_zoom_webinar_meta`
--
ALTER TABLE `tukk_bp_zoom_webinar_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_bp_zoom_webinar_recordings`
--
ALTER TABLE `tukk_bp_zoom_webinar_recordings`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_commentmeta`
--
ALTER TABLE `tukk_commentmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_comments`
--
ALTER TABLE `tukk_comments`
  MODIFY `comment_ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_e_events`
--
ALTER TABLE `tukk_e_events`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_e_notes`
--
ALTER TABLE `tukk_e_notes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_e_notes_users_relations`
--
ALTER TABLE `tukk_e_notes_users_relations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_e_submissions`
--
ALTER TABLE `tukk_e_submissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_e_submissions_actions_log`
--
ALTER TABLE `tukk_e_submissions_actions_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_e_submissions_values`
--
ALTER TABLE `tukk_e_submissions_values`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_facetwp_index`
--
ALTER TABLE `tukk_facetwp_index`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_gf_addon_feed`
--
ALTER TABLE `tukk_gf_addon_feed`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_gf_addon_payment_transaction`
--
ALTER TABLE `tukk_gf_addon_payment_transaction`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_gf_entry`
--
ALTER TABLE `tukk_gf_entry`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_gf_entry_meta`
--
ALTER TABLE `tukk_gf_entry_meta`
  MODIFY `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_gf_entry_notes`
--
ALTER TABLE `tukk_gf_entry_notes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_gf_form`
--
ALTER TABLE `tukk_gf_form`
  MODIFY `id` mediumint(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_gf_form_revisions`
--
ALTER TABLE `tukk_gf_form_revisions`
  MODIFY `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_gf_form_view`
--
ALTER TABLE `tukk_gf_form_view`
  MODIFY `id` bigint(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_gf_rest_api_keys`
--
ALTER TABLE `tukk_gf_rest_api_keys`
  MODIFY `key_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_links`
--
ALTER TABLE `tukk_links`
  MODIFY `link_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_options`
--
ALTER TABLE `tukk_options`
  MODIFY `option_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_pmxi_files`
--
ALTER TABLE `tukk_pmxi_files`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_pmxi_geocoding`
--
ALTER TABLE `tukk_pmxi_geocoding`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_pmxi_history`
--
ALTER TABLE `tukk_pmxi_history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_pmxi_images`
--
ALTER TABLE `tukk_pmxi_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_pmxi_imports`
--
ALTER TABLE `tukk_pmxi_imports`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_pmxi_posts`
--
ALTER TABLE `tukk_pmxi_posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_pmxi_templates`
--
ALTER TABLE `tukk_pmxi_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_postmeta`
--
ALTER TABLE `tukk_postmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_posts`
--
ALTER TABLE `tukk_posts`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_post_smtp_logmeta`
--
ALTER TABLE `tukk_post_smtp_logmeta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_post_smtp_logs`
--
ALTER TABLE `tukk_post_smtp_logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_pronamic_pay_mollie_customers`
--
ALTER TABLE `tukk_pronamic_pay_mollie_customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_pronamic_pay_mollie_customer_users`
--
ALTER TABLE `tukk_pronamic_pay_mollie_customer_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_pronamic_pay_mollie_organizations`
--
ALTER TABLE `tukk_pronamic_pay_mollie_organizations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_pronamic_pay_mollie_profiles`
--
ALTER TABLE `tukk_pronamic_pay_mollie_profiles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_signups`
--
ALTER TABLE `tukk_signups`
  MODIFY `signup_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_termmeta`
--
ALTER TABLE `tukk_termmeta`
  MODIFY `meta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_terms`
--
ALTER TABLE `tukk_terms`
  MODIFY `term_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_term_taxonomy`
--
ALTER TABLE `tukk_term_taxonomy`
  MODIFY `term_taxonomy_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_uap_action_log`
--
ALTER TABLE `tukk_uap_action_log`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_uap_action_log_meta`
--
ALTER TABLE `tukk_uap_action_log_meta`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_uap_api_log`
--
ALTER TABLE `tukk_uap_api_log`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_uap_closure_log`
--
ALTER TABLE `tukk_uap_closure_log`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_uap_closure_log_meta`
--
ALTER TABLE `tukk_uap_closure_log_meta`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_uap_recipe_log`
--
ALTER TABLE `tukk_uap_recipe_log`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_uap_trigger_log`
--
ALTER TABLE `tukk_uap_trigger_log`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_uap_trigger_log_meta`
--
ALTER TABLE `tukk_uap_trigger_log_meta`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_usermeta`
--
ALTER TABLE `tukk_usermeta`
  MODIFY `umeta_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_users`
--
ALTER TABLE `tukk_users`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_wpmailsmtp_debug_events`
--
ALTER TABLE `tukk_wpmailsmtp_debug_events`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_wpmailsmtp_tasks_meta`
--
ALTER TABLE `tukk_wpmailsmtp_tasks_meta`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_wpr_above_the_fold`
--
ALTER TABLE `tukk_wpr_above_the_fold`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_wpr_lazy_render_content`
--
ALTER TABLE `tukk_wpr_lazy_render_content`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_wpr_rocket_cache`
--
ALTER TABLE `tukk_wpr_rocket_cache`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_wpr_rucss_used_css`
--
ALTER TABLE `tukk_wpr_rucss_used_css`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_yoast_indexable`
--
ALTER TABLE `tukk_yoast_indexable`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_yoast_migrations`
--
ALTER TABLE `tukk_yoast_migrations`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_yoast_primary_term`
--
ALTER TABLE `tukk_yoast_primary_term`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tukk_yoast_seo_links`
--
ALTER TABLE `tukk_yoast_seo_links`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
