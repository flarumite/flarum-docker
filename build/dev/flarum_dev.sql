-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               8.0.25 - MySQL Community Server - GPL
-- Server OS:                    Linux
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for flarum
DROP DATABASE IF EXISTS `flarum`;
CREATE DATABASE IF NOT EXISTS `flarum` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `flarum`;

-- Dumping structure for table flarum.flarum_access_tokens
DROP TABLE IF EXISTS `flarum_access_tokens`;
CREATE TABLE IF NOT EXISTS `flarum_access_tokens` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int unsigned NOT NULL,
  `last_activity_at` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `flarum_access_tokens_token_unique` (`token`),
  KEY `flarum_access_tokens_user_id_foreign` (`user_id`),
  KEY `flarum_access_tokens_type_index` (`type`),
  CONSTRAINT `flarum_access_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_access_tokens: ~2 rows (approximately)
/*!40000 ALTER TABLE `flarum_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_access_tokens` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_api_keys
DROP TABLE IF EXISTS `flarum_api_keys`;
CREATE TABLE IF NOT EXISTS `flarum_api_keys` (
  `key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `allowed_ips` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `last_activity_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `flarum_api_keys_key_unique` (`key`),
  KEY `flarum_api_keys_user_id_foreign` (`user_id`),
  CONSTRAINT `flarum_api_keys_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_api_keys: ~0 rows (approximately)
/*!40000 ALTER TABLE `flarum_api_keys` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_api_keys` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_decontaminator
DROP TABLE IF EXISTS `flarum_decontaminator`;
CREATE TABLE IF NOT EXISTS `flarum_decontaminator` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `flag` tinyint(1) NOT NULL,
  `event` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `replacement` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` datetime NOT NULL,
  `edit_time` datetime DEFAULT NULL,
  `regex` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_decontaminator: ~1 rows (approximately)
/*!40000 ALTER TABLE `flarum_decontaminator` DISABLE KEYS */;
REPLACE INTO `flarum_decontaminator` (`id`, `type`, `name`, `flag`, `event`, `replacement`, `time`, `edit_time`, `regex`) VALUES
	(1, '', 'Example: Wibble', 1, 'save', '<censored>', '2020-05-10 14:42:44', NULL, '/wibble/mi');
/*!40000 ALTER TABLE `flarum_decontaminator` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_discussions
DROP TABLE IF EXISTS `flarum_discussions`;
CREATE TABLE IF NOT EXISTS `flarum_discussions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment_count` int NOT NULL DEFAULT '1',
  `participant_count` int unsigned NOT NULL DEFAULT '0',
  `post_number_index` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `first_post_id` int unsigned DEFAULT NULL,
  `last_posted_at` datetime DEFAULT NULL,
  `last_posted_user_id` int unsigned DEFAULT NULL,
  `last_post_id` int unsigned DEFAULT NULL,
  `last_post_number` int unsigned DEFAULT NULL,
  `hidden_at` datetime DEFAULT NULL,
  `hidden_user_id` int unsigned DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  `is_approved` tinyint(1) NOT NULL DEFAULT '1',
  `is_locked` tinyint(1) NOT NULL DEFAULT '0',
  `is_sticky` tinyint(1) NOT NULL DEFAULT '0',
  `best_answer_post_id` int unsigned DEFAULT NULL,
  `best_answer_user_id` int unsigned DEFAULT NULL,
  `best_answer_notified` tinyint(1) NOT NULL,
  `best_answer_set_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `flarum_discussions_hidden_user_id_foreign` (`hidden_user_id`),
  KEY `flarum_discussions_first_post_id_foreign` (`first_post_id`),
  KEY `flarum_discussions_last_post_id_foreign` (`last_post_id`),
  KEY `flarum_discussions_last_posted_at_index` (`last_posted_at`),
  KEY `flarum_discussions_last_posted_user_id_index` (`last_posted_user_id`),
  KEY `flarum_discussions_created_at_index` (`created_at`),
  KEY `flarum_discussions_user_id_index` (`user_id`),
  KEY `flarum_discussions_comment_count_index` (`comment_count`),
  KEY `flarum_discussions_participant_count_index` (`participant_count`),
  KEY `flarum_discussions_hidden_at_index` (`hidden_at`),
  KEY `flarum_discussions_is_locked_index` (`is_locked`),
  KEY `flarum_discussions_is_sticky_created_at_index` (`is_sticky`,`created_at`),
  KEY `flarum_discussions_best_answer_post_id_foreign` (`best_answer_post_id`),
  KEY `flarum_discussions_best_answer_user_id_foreign` (`best_answer_user_id`),
  KEY `flarum_discussions_best_answer_set_at_index` (`best_answer_set_at`),
  KEY `flarum_discussions_is_sticky_last_posted_at_index` (`is_sticky`,`last_posted_at`),
  FULLTEXT KEY `title` (`title`),
  CONSTRAINT `flarum_discussions_best_answer_post_id_foreign` FOREIGN KEY (`best_answer_post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `flarum_discussions_best_answer_user_id_foreign` FOREIGN KEY (`best_answer_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `flarum_discussions_first_post_id_foreign` FOREIGN KEY (`first_post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `flarum_discussions_hidden_user_id_foreign` FOREIGN KEY (`hidden_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `flarum_discussions_last_post_id_foreign` FOREIGN KEY (`last_post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `flarum_discussions_last_posted_user_id_foreign` FOREIGN KEY (`last_posted_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `flarum_discussions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_discussions: ~0 rows (approximately)
/*!40000 ALTER TABLE `flarum_discussions` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_discussions` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_discussion_tag
DROP TABLE IF EXISTS `flarum_discussion_tag`;
CREATE TABLE IF NOT EXISTS `flarum_discussion_tag` (
  `discussion_id` int unsigned NOT NULL,
  `tag_id` int unsigned NOT NULL,
  PRIMARY KEY (`discussion_id`,`tag_id`),
  KEY `flarum_discussion_tag_tag_id_foreign` (`tag_id`),
  CONSTRAINT `flarum_discussion_tag_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `flarum_discussions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_discussion_tag_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `flarum_tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_discussion_tag: ~0 rows (approximately)
/*!40000 ALTER TABLE `flarum_discussion_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_discussion_tag` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_discussion_user
DROP TABLE IF EXISTS `flarum_discussion_user`;
CREATE TABLE IF NOT EXISTS `flarum_discussion_user` (
  `user_id` int unsigned NOT NULL,
  `discussion_id` int unsigned NOT NULL,
  `last_read_at` datetime DEFAULT NULL,
  `last_read_post_number` int unsigned DEFAULT NULL,
  `subscription` enum('follow','ignore') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`,`discussion_id`),
  KEY `flarum_discussion_user_discussion_id_foreign` (`discussion_id`),
  CONSTRAINT `flarum_discussion_user_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `flarum_discussions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_discussion_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_discussion_user: ~0 rows (approximately)
/*!40000 ALTER TABLE `flarum_discussion_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_discussion_user` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_email_tokens
DROP TABLE IF EXISTS `flarum_email_tokens`;
CREATE TABLE IF NOT EXISTS `flarum_email_tokens` (
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int unsigned NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`token`),
  KEY `flarum_email_tokens_user_id_foreign` (`user_id`),
  CONSTRAINT `flarum_email_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_email_tokens: ~0 rows (approximately)
/*!40000 ALTER TABLE `flarum_email_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_email_tokens` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_flags
DROP TABLE IF EXISTS `flarum_flags`;
CREATE TABLE IF NOT EXISTS `flarum_flags` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int unsigned NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reason_detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `flarum_flags_post_id_foreign` (`post_id`),
  KEY `flarum_flags_user_id_foreign` (`user_id`),
  KEY `flarum_flags_created_at_index` (`created_at`),
  CONSTRAINT `flarum_flags_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_flags_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_flags: ~0 rows (approximately)
/*!40000 ALTER TABLE `flarum_flags` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_flags` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_fof_upload_downloads
DROP TABLE IF EXISTS `flarum_fof_upload_downloads`;
CREATE TABLE IF NOT EXISTS `flarum_fof_upload_downloads` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `file_id` int unsigned NOT NULL,
  `discussion_id` int unsigned DEFAULT NULL,
  `post_id` int unsigned DEFAULT NULL,
  `actor_id` int unsigned DEFAULT NULL,
  `downloaded_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `flarum_fof_upload_downloads_file_id_foreign` (`file_id`),
  KEY `flarum_fof_upload_downloads_discussion_id_foreign` (`discussion_id`),
  KEY `flarum_fof_upload_downloads_actor_id_foreign` (`actor_id`),
  KEY `flarum_fof_upload_downloads_post_id_foreign` (`post_id`),
  CONSTRAINT `flarum_fof_upload_downloads_actor_id_foreign` FOREIGN KEY (`actor_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `flarum_fof_upload_downloads_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `flarum_discussions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `flarum_fof_upload_downloads_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `flarum_fof_upload_files` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_fof_upload_downloads_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_fof_upload_downloads: ~0 rows (approximately)
/*!40000 ALTER TABLE `flarum_fof_upload_downloads` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_fof_upload_downloads` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_fof_upload_files
DROP TABLE IF EXISTS `flarum_fof_upload_files`;
CREATE TABLE IF NOT EXISTS `flarum_fof_upload_files` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `actor_id` int unsigned DEFAULT NULL,
  `discussion_id` int unsigned DEFAULT NULL,
  `post_id` int unsigned DEFAULT NULL,
  `base_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` int NOT NULL,
  `upload_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `remote_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hide_from_media_manager` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_fof_upload_files: ~0 rows (approximately)
/*!40000 ALTER TABLE `flarum_fof_upload_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_fof_upload_files` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_groups
DROP TABLE IF EXISTS `flarum_groups`;
CREATE TABLE IF NOT EXISTS `flarum_groups` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name_singular` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_plural` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_groups: ~4 rows (approximately)
/*!40000 ALTER TABLE `flarum_groups` DISABLE KEYS */;
REPLACE INTO `flarum_groups` (`id`, `name_singular`, `name_plural`, `color`, `icon`, `is_hidden`) VALUES
	(1, 'Admin', 'Admins', '#B72A2A', 'fas fa-wrench', 0),
	(2, 'Guest', 'Guests', NULL, NULL, 0),
	(3, 'Member', 'Members', NULL, NULL, 0),
	(4, 'Mod', 'Mods', '#80349E', 'fas fa-bolt', 0);
/*!40000 ALTER TABLE `flarum_groups` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_group_permission
DROP TABLE IF EXISTS `flarum_group_permission`;
CREATE TABLE IF NOT EXISTS `flarum_group_permission` (
  `group_id` int unsigned NOT NULL,
  `permission` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`group_id`,`permission`),
  CONSTRAINT `flarum_group_permission_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `flarum_groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_group_permission: ~28 rows (approximately)
/*!40000 ALTER TABLE `flarum_group_permission` DISABLE KEYS */;
REPLACE INTO `flarum_group_permission` (`group_id`, `permission`) VALUES
	(2, 'viewForum'),
	(3, 'discussion.flagPosts'),
	(3, 'discussion.likePosts'),
	(3, 'discussion.reactPosts'),
	(3, 'discussion.reply'),
	(3, 'discussion.replyWithoutApproval'),
	(3, 'discussion.selectBestAnswerOwnDiscussion'),
	(3, 'discussion.startWithoutApproval'),
	(3, 'searchUsers'),
	(3, 'startDiscussion'),
	(3, 'user.beFollowed'),
	(4, 'discussion.approvePosts'),
	(4, 'discussion.editPosts'),
	(4, 'discussion.hide'),
	(4, 'discussion.hidePosts'),
	(4, 'discussion.lock'),
	(4, 'discussion.rename'),
	(4, 'discussion.sticky'),
	(4, 'discussion.tag'),
	(4, 'discussion.viewFlags'),
	(4, 'discussion.viewIpsPosts'),
	(4, 'fof-upload.deleteUserUploads'),
	(4, 'fof-upload.viewUserUploads'),
	(4, 'user.bypassDecontaminator'),
	(4, 'user.createModeratorNotes'),
	(4, 'user.suspend'),
	(4, 'user.viewLastSeenAt'),
	(4, 'user.viewModeratorNotes');
/*!40000 ALTER TABLE `flarum_group_permission` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_group_user
DROP TABLE IF EXISTS `flarum_group_user`;
CREATE TABLE IF NOT EXISTS `flarum_group_user` (
  `user_id` int unsigned NOT NULL,
  `group_id` int unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`group_id`),
  KEY `flarum_group_user_group_id_foreign` (`group_id`),
  CONSTRAINT `flarum_group_user_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `flarum_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_group_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_group_user: ~2 rows (approximately)
/*!40000 ALTER TABLE `flarum_group_user` DISABLE KEYS */;
REPLACE INTO `flarum_group_user` (`user_id`, `group_id`) VALUES
	(1, 1),
	(2, 4);
/*!40000 ALTER TABLE `flarum_group_user` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_ignored_user
DROP TABLE IF EXISTS `flarum_ignored_user`;
CREATE TABLE IF NOT EXISTS `flarum_ignored_user` (
  `user_id` int unsigned NOT NULL,
  `ignored_user_id` int unsigned NOT NULL,
  `ignored_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`ignored_user_id`),
  KEY `flarum_ignored_user_ignored_user_id_foreign` (`ignored_user_id`),
  CONSTRAINT `flarum_ignored_user_ignored_user_id_foreign` FOREIGN KEY (`ignored_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_ignored_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_ignored_user: ~0 rows (approximately)
/*!40000 ALTER TABLE `flarum_ignored_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_ignored_user` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_links
DROP TABLE IF EXISTS `flarum_links`;
CREATE TABLE IF NOT EXISTS `flarum_links` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` int DEFAULT NULL,
  `is_internal` tinyint(1) NOT NULL DEFAULT '0',
  `is_newtab` tinyint(1) NOT NULL DEFAULT '0',
  `parent_id` int unsigned DEFAULT NULL,
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `visibility` enum('everyone','members','guests') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'everyone',
  PRIMARY KEY (`id`),
  KEY `flarum_links_parent_id_foreign` (`parent_id`),
  KEY `flarum_links_visibility_index` (`visibility`),
  CONSTRAINT `flarum_links_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `flarum_links` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_links: ~0 rows (approximately)
/*!40000 ALTER TABLE `flarum_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_links` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_login_providers
DROP TABLE IF EXISTS `flarum_login_providers`;
CREATE TABLE IF NOT EXISTS `flarum_login_providers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `provider` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `identifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `flarum_login_providers_provider_identifier_unique` (`provider`,`identifier`),
  KEY `flarum_login_providers_user_id_foreign` (`user_id`),
  CONSTRAINT `flarum_login_providers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_login_providers: ~0 rows (approximately)
/*!40000 ALTER TABLE `flarum_login_providers` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_login_providers` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_migrations
DROP TABLE IF EXISTS `flarum_migrations`;
CREATE TABLE IF NOT EXISTS `flarum_migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `extension` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_migrations: ~182 rows (approximately)
/*!40000 ALTER TABLE `flarum_migrations` DISABLE KEYS */;
REPLACE INTO `flarum_migrations` (`id`, `migration`, `extension`) VALUES
	(1, '2015_02_24_000000_create_access_tokens_table', NULL),
	(2, '2015_02_24_000000_create_api_keys_table', NULL),
	(3, '2015_02_24_000000_create_config_table', NULL),
	(4, '2015_02_24_000000_create_discussions_table', NULL),
	(5, '2015_02_24_000000_create_email_tokens_table', NULL),
	(6, '2015_02_24_000000_create_groups_table', NULL),
	(7, '2015_02_24_000000_create_notifications_table', NULL),
	(8, '2015_02_24_000000_create_password_tokens_table', NULL),
	(9, '2015_02_24_000000_create_permissions_table', NULL),
	(10, '2015_02_24_000000_create_posts_table', NULL),
	(11, '2015_02_24_000000_create_users_discussions_table', NULL),
	(12, '2015_02_24_000000_create_users_groups_table', NULL),
	(13, '2015_02_24_000000_create_users_table', NULL),
	(14, '2015_09_15_000000_create_auth_tokens_table', NULL),
	(15, '2015_09_20_224327_add_hide_to_discussions', NULL),
	(16, '2015_09_22_030432_rename_notification_read_time', NULL),
	(17, '2015_10_07_130531_rename_config_to_settings', NULL),
	(18, '2015_10_24_194000_add_ip_address_to_posts', NULL),
	(19, '2015_12_05_042721_change_access_tokens_columns', NULL),
	(20, '2015_12_17_194247_change_settings_value_column_to_text', NULL),
	(21, '2016_02_04_095452_add_slug_to_discussions', NULL),
	(22, '2017_04_07_114138_add_is_private_to_discussions', NULL),
	(23, '2017_04_07_114138_add_is_private_to_posts', NULL),
	(24, '2018_01_11_093900_change_access_tokens_columns', NULL),
	(25, '2018_01_11_094000_change_access_tokens_add_foreign_keys', NULL),
	(26, '2018_01_11_095000_change_api_keys_columns', NULL),
	(27, '2018_01_11_101800_rename_auth_tokens_to_registration_tokens', NULL),
	(28, '2018_01_11_102000_change_registration_tokens_rename_id_to_token', NULL),
	(29, '2018_01_11_102100_change_registration_tokens_created_at_to_datetime', NULL),
	(30, '2018_01_11_120604_change_posts_table_to_innodb', NULL),
	(31, '2018_01_11_155200_change_discussions_rename_columns', NULL),
	(32, '2018_01_11_155300_change_discussions_add_foreign_keys', NULL),
	(33, '2018_01_15_071700_rename_users_discussions_to_discussion_user', NULL),
	(34, '2018_01_15_071800_change_discussion_user_rename_columns', NULL),
	(35, '2018_01_15_071900_change_discussion_user_add_foreign_keys', NULL),
	(36, '2018_01_15_072600_change_email_tokens_rename_id_to_token', NULL),
	(37, '2018_01_15_072700_change_email_tokens_add_foreign_keys', NULL),
	(38, '2018_01_15_072800_change_email_tokens_created_at_to_datetime', NULL),
	(39, '2018_01_18_130400_rename_permissions_to_group_permission', NULL),
	(40, '2018_01_18_130500_change_group_permission_add_foreign_keys', NULL),
	(41, '2018_01_18_130600_rename_users_groups_to_group_user', NULL),
	(42, '2018_01_18_130700_change_group_user_add_foreign_keys', NULL),
	(43, '2018_01_18_133000_change_notifications_columns', NULL),
	(44, '2018_01_18_133100_change_notifications_add_foreign_keys', NULL),
	(45, '2018_01_18_134400_change_password_tokens_rename_id_to_token', NULL),
	(46, '2018_01_18_134500_change_password_tokens_add_foreign_keys', NULL),
	(47, '2018_01_18_134600_change_password_tokens_created_at_to_datetime', NULL),
	(48, '2018_01_18_135000_change_posts_rename_columns', NULL),
	(49, '2018_01_18_135100_change_posts_add_foreign_keys', NULL),
	(50, '2018_01_30_112238_add_fulltext_index_to_discussions_title', NULL),
	(51, '2018_01_30_220100_create_post_user_table', NULL),
	(52, '2018_01_30_222900_change_users_rename_columns', NULL),
	(53, '2018_07_21_000000_seed_default_groups', NULL),
	(54, '2018_07_21_000100_seed_default_group_permissions', NULL),
	(55, '2018_09_15_041340_add_users_indicies', NULL),
	(56, '2018_09_15_041828_add_discussions_indicies', NULL),
	(57, '2018_09_15_043337_add_notifications_indices', NULL),
	(58, '2018_09_15_043621_add_posts_indices', NULL),
	(59, '2018_09_22_004100_change_registration_tokens_columns', NULL),
	(60, '2018_09_22_004200_create_login_providers_table', NULL),
	(61, '2018_10_08_144700_add_shim_prefix_to_group_icons', NULL),
	(62, '2019_06_24_145100_change_posts_content_column_to_mediumtext', NULL),
	(63, '2019_10_12_195349_change_posts_add_discussion_foreign_key', NULL),
	(64, '2020_03_19_134512_change_discussions_default_comment_count', NULL),
	(65, '2020_04_21_130500_change_permission_groups_add_is_hidden', NULL),
	(66, '2015_09_21_011527_add_is_approved_to_discussions', 'flarum-approval'),
	(67, '2015_09_21_011706_add_is_approved_to_posts', 'flarum-approval'),
	(68, '2017_07_22_000000_add_default_permissions', 'flarum-approval'),
	(69, '2018_09_29_060444_replace_emoji_shorcuts_with_unicode', 'flarum-emoji'),
	(70, '2015_09_02_000000_add_flags_read_time_to_users_table', 'flarum-flags'),
	(71, '2015_09_02_000000_create_flags_table', 'flarum-flags'),
	(72, '2017_07_22_000000_add_default_permissions', 'flarum-flags'),
	(73, '2018_06_27_101500_change_flags_rename_time_to_created_at', 'flarum-flags'),
	(74, '2018_06_27_101600_change_flags_add_foreign_keys', 'flarum-flags'),
	(75, '2018_06_27_105100_change_users_rename_flags_read_time_to_read_flags_at', 'flarum-flags'),
	(76, '2018_09_15_043621_add_flags_indices', 'flarum-flags'),
	(77, '2019_10_22_000000_change_reason_text_col_type', 'flarum-flags'),
	(78, '2015_05_11_000000_create_posts_likes_table', 'flarum-likes'),
	(79, '2015_09_04_000000_add_default_like_permissions', 'flarum-likes'),
	(80, '2018_06_27_100600_rename_posts_likes_to_post_likes', 'flarum-likes'),
	(81, '2018_06_27_100700_change_post_likes_add_foreign_keys', 'flarum-likes'),
	(82, '2015_02_24_000000_add_locked_to_discussions', 'flarum-lock'),
	(83, '2017_07_22_000000_add_default_permissions', 'flarum-lock'),
	(84, '2018_09_15_043621_add_discussions_indices', 'flarum-lock'),
	(85, '2015_05_11_000000_create_mentions_posts_table', 'flarum-mentions'),
	(86, '2015_05_11_000000_create_mentions_users_table', 'flarum-mentions'),
	(87, '2018_06_27_102000_rename_mentions_posts_to_post_mentions_post', 'flarum-mentions'),
	(88, '2018_06_27_102100_rename_mentions_users_to_post_mentions_user', 'flarum-mentions'),
	(89, '2018_06_27_102200_change_post_mentions_post_rename_mentions_id_to_mentions_post_id', 'flarum-mentions'),
	(90, '2018_06_27_102300_change_post_mentions_post_add_foreign_keys', 'flarum-mentions'),
	(91, '2018_06_27_102400_change_post_mentions_user_rename_mentions_id_to_mentions_user_id', 'flarum-mentions'),
	(92, '2018_06_27_102500_change_post_mentions_user_add_foreign_keys', 'flarum-mentions'),
	(93, '2015_02_24_000000_add_sticky_to_discussions', 'flarum-sticky'),
	(94, '2017_07_22_000000_add_default_permissions', 'flarum-sticky'),
	(95, '2018_09_15_043621_add_discussions_indices', 'flarum-sticky'),
	(96, '2015_05_11_000000_add_subscription_to_users_discussions_table', 'flarum-subscriptions'),
	(97, '2015_05_11_000000_add_suspended_until_to_users_table', 'flarum-suspend'),
	(98, '2015_09_14_000000_rename_suspended_until_column', 'flarum-suspend'),
	(99, '2017_07_22_000000_add_default_permissions', 'flarum-suspend'),
	(100, '2018_06_27_111400_change_users_rename_suspend_until_to_suspended_until', 'flarum-suspend'),
	(101, '2015_02_24_000000_create_discussions_tags_table', 'flarum-tags'),
	(102, '2015_02_24_000000_create_tags_table', 'flarum-tags'),
	(103, '2015_02_24_000000_create_users_tags_table', 'flarum-tags'),
	(104, '2015_02_24_000000_set_default_settings', 'flarum-tags'),
	(105, '2015_10_19_061223_make_slug_unique', 'flarum-tags'),
	(106, '2017_07_22_000000_add_default_permissions', 'flarum-tags'),
	(107, '2018_06_27_085200_change_tags_columns', 'flarum-tags'),
	(108, '2018_06_27_085300_change_tags_add_foreign_keys', 'flarum-tags'),
	(109, '2018_06_27_090400_rename_users_tags_to_tag_user', 'flarum-tags'),
	(110, '2018_06_27_100100_change_tag_user_rename_read_time_to_marked_as_read_at', 'flarum-tags'),
	(111, '2018_06_27_100200_change_tag_user_add_foreign_keys', 'flarum-tags'),
	(112, '2018_06_27_103000_rename_discussions_tags_to_discussion_tag', 'flarum-tags'),
	(113, '2018_06_27_103100_add_discussion_tag_foreign_keys', 'flarum-tags'),
	(114, '2019_04_21_000000_add_icon_to_tags_table', 'flarum-tags'),
	(115, '2019_06_29_000000_create_ignored_users_table', 'fof-ignore-users'),
	(116, '2020_05_05_000000_migrate_extension_settings', 'fof-impersonate'),
	(117, '2016_02_13_000000_create_links_table', 'fof-links'),
	(118, '2016_04_19_065618_change_links_columns', 'fof-links'),
	(119, '2020_03_16_000000_add_child_links', 'fof-links'),
	(120, '2020_02_25_000001_create_moderator_notes_table', 'fof-moderator-notes'),
	(121, '2020_02_25_000002_add_default_permissions', 'fof-moderator-notes'),
	(122, '2020_02_29_000001_modify_users_notes_foreign_keys', 'fof-moderator-notes'),
	(123, '2019_11_04_000001_add_columns_to_discussions_table', 'fof-best-answer'),
	(124, '2019_11_04_000002_add_foreign_keys_to_best_anwer_columns', 'fof-best-answer'),
	(125, '2019_11_04_000003_migrate_extension_settings', 'fof-best-answer'),
	(126, '2020_02_04_205300_add_best_answer_set_timestamp', 'fof-best-answer'),
	(127, '2019_07_08_000000_create_reactions_tables', 'fof-reactions'),
	(128, '2019_07_08_000001_create_post_reactions_table', 'fof-reactions'),
	(129, '2019_07_08_000002_add_default_reaction_permission', 'fof-reactions'),
	(130, '2019_07_08_000003_migrate_extension_settings', 'fof-reactions'),
	(131, '2019_12_05_000000_add_timestamps_to_post_reactions_table', 'fof-reactions'),
	(132, '2019_12_13_120237_add_enabled_column_to_reactions_table', 'fof-reactions'),
	(133, '2020_01_19_000000_add_display_column_to_reactions_table', 'fof-reactions'),
	(134, '2019_06_07_000000_add_recipients_table', 'fof-byobu'),
	(135, '2019_06_07_000001_remove_flagrow_migrations', 'fof-byobu'),
	(136, '2019_07_08_000000_add_blocks_pd_to_users', 'fof-byobu'),
	(137, '2019_07_09_000000_blocks_pd_index', 'fof-byobu'),
	(138, '2020_02_14_214800_fix_user_id_not_nullable_for_group_pds', 'fof-byobu'),
	(139, '2020_02_19_110103_remove_retired_settings_key', 'fof-byobu'),
	(140, '2019_06_11_000000_add_subscription_to_users_tags_table', 'fof-follow-tags'),
	(141, '2019_06_28_000000_add_hide_subscription_option', 'fof-follow-tags'),
	(142, '2020_02_06_01_rename_flagrow_permissions', 'fof-upload'),
	(143, '2020_02_06_02_rename_flagrow_settings', 'fof-upload'),
	(144, '2020_02_06_03_rename_flagrow_tables', 'fof-upload'),
	(145, '2020_02_06_04_remove_flagrow_migrations', 'fof-upload'),
	(146, '2020_02_06_05_create_files_table', 'fof-upload'),
	(147, '2020_02_06_06_create_downloads_table', 'fof-upload'),
	(148, '2020_02_06_07_alter_downloads_add_post_constraint', 'fof-upload'),
	(149, '2020_04_12_213100__create_profanities_table', 'flarumite-decontaminator'),
	(150, '2020_05_10_000000_create_sample_rule', 'flarumite-decontaminator'),
	(151, '2020_05_10_000001_rename_profanities_to_decontaminator', 'flarumite-decontaminator'),
	(152, '2020_05_10_000002_default_permissions', 'flarumite-decontaminator'),
	(153, '2020_07_01_000000_create_bio_column', 'fof-user-bio'),
	(154, '2020_09_10_000000_add_icon_to_links_table', 'fof-links'),
	(155, '2020_04_31_000000_format_note_content_for_renderer', 'fof-moderator-notes'),
	(156, '2020_06_07_000000_set_default', 'fof-sitemap'),
	(157, '2020_10_23_000000_users_unified_index_column', 'fof-byobu'),
	(158, '2021_03_02_040000_change_access_tokens_add_type', NULL),
	(159, '2021_03_02_040500_change_access_tokens_add_id', NULL),
	(160, '2021_03_02_041000_change_access_tokens_add_title_ip_agent', NULL),
	(161, '2021_04_18_040500_change_migrations_add_id_primary_key', NULL),
	(162, '2021_04_18_145100_change_posts_content_column_to_mediumtext', NULL),
	(163, '2021_05_10_000000_rename_permissions', NULL),
	(164, '2021_02_11_01_add_uploads_view_and_delete_permissions', 'fof-upload'),
	(165, '2021_03_13_000000_alter_upload_files_add_hidden_from_media_manager', 'fof-upload'),
	(166, '2021_03_13_set_created_at_to_default_as_current_timestamp', 'fof-upload'),
	(167, '2021_01_22_000000_add_indicies', 'fof-follow-tags'),
	(168, '2021_01_13_000000_unified_index_index', 'fof-byobu'),
	(169, '2021_01_13_000001_byobu_indicies', 'fof-byobu'),
	(170, '2021_01_23_000000_drop_tags_from_old_private_discussions', 'fof-byobu'),
	(171, '2021_04_21_000000_drop_users_unified_index_column', 'fof-byobu'),
	(172, '2021_01_17_000000_add_registered_users_only_to_links_table', 'fof-links'),
	(173, '2021_01_17_000001_add_visibility_to_links_table', 'fof-links'),
	(174, '2021_01_17_000001_drop_registered_users_only_column_and_migrate_options', 'fof-links'),
	(175, '2021_01_17_000000_set_default_bio_length', 'fof-user-bio'),
	(176, '2021_01_13_000000_add_discussion_last_posted_at_indices', 'flarum-sticky'),
	(177, '2021_04_19_000000_set_default_settings', 'flarum-mentions'),
	(178, '2021_03_25_000000_default_settings', 'flarum-markdown'),
	(179, '0000_00_00_000000_create_user_followers_table', 'ianm-follow-users'),
	(180, '0000_00_00_000001_set_default_permissions', 'ianm-follow-users'),
	(181, '2021_03_07_000000_set_empty_links', 'davwheat-custom-sidenav-links'),
	(182, '2021_03_11_000000_set_display_settings', 'davwheat-custom-sidenav-links');
/*!40000 ALTER TABLE `flarum_migrations` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_notifications
DROP TABLE IF EXISTS `flarum_notifications`;
CREATE TABLE IF NOT EXISTS `flarum_notifications` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `from_user_id` int unsigned DEFAULT NULL,
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_id` int unsigned DEFAULT NULL,
  `data` blob,
  `created_at` datetime NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `read_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `flarum_notifications_from_user_id_foreign` (`from_user_id`),
  KEY `flarum_notifications_user_id_index` (`user_id`),
  CONSTRAINT `flarum_notifications_from_user_id_foreign` FOREIGN KEY (`from_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `flarum_notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_notifications: ~0 rows (approximately)
/*!40000 ALTER TABLE `flarum_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_notifications` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_password_tokens
DROP TABLE IF EXISTS `flarum_password_tokens`;
CREATE TABLE IF NOT EXISTS `flarum_password_tokens` (
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int unsigned NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`token`),
  KEY `flarum_password_tokens_user_id_foreign` (`user_id`),
  CONSTRAINT `flarum_password_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_password_tokens: ~0 rows (approximately)
/*!40000 ALTER TABLE `flarum_password_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_password_tokens` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_posts
DROP TABLE IF EXISTS `flarum_posts`;
CREATE TABLE IF NOT EXISTS `flarum_posts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `discussion_id` int unsigned NOT NULL,
  `number` int unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT ' ',
  `edited_at` datetime DEFAULT NULL,
  `edited_user_id` int unsigned DEFAULT NULL,
  `hidden_at` datetime DEFAULT NULL,
  `hidden_user_id` int unsigned DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  `is_approved` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `flarum_posts_discussion_id_number_unique` (`discussion_id`,`number`),
  KEY `flarum_posts_edited_user_id_foreign` (`edited_user_id`),
  KEY `flarum_posts_hidden_user_id_foreign` (`hidden_user_id`),
  KEY `flarum_posts_discussion_id_number_index` (`discussion_id`,`number`),
  KEY `flarum_posts_discussion_id_created_at_index` (`discussion_id`,`created_at`),
  KEY `flarum_posts_user_id_created_at_index` (`user_id`,`created_at`),
  FULLTEXT KEY `content` (`content`),
  CONSTRAINT `flarum_posts_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `flarum_discussions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_posts_edited_user_id_foreign` FOREIGN KEY (`edited_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `flarum_posts_hidden_user_id_foreign` FOREIGN KEY (`hidden_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `flarum_posts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_posts: ~0 rows (approximately)
/*!40000 ALTER TABLE `flarum_posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_posts` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_post_likes
DROP TABLE IF EXISTS `flarum_post_likes`;
CREATE TABLE IF NOT EXISTS `flarum_post_likes` (
  `post_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  PRIMARY KEY (`post_id`,`user_id`),
  KEY `flarum_post_likes_user_id_foreign` (`user_id`),
  CONSTRAINT `flarum_post_likes_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_post_likes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_post_likes: ~0 rows (approximately)
/*!40000 ALTER TABLE `flarum_post_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_post_likes` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_post_mentions_post
DROP TABLE IF EXISTS `flarum_post_mentions_post`;
CREATE TABLE IF NOT EXISTS `flarum_post_mentions_post` (
  `post_id` int unsigned NOT NULL,
  `mentions_post_id` int unsigned NOT NULL,
  PRIMARY KEY (`post_id`,`mentions_post_id`),
  KEY `flarum_post_mentions_post_mentions_post_id_foreign` (`mentions_post_id`),
  CONSTRAINT `flarum_post_mentions_post_mentions_post_id_foreign` FOREIGN KEY (`mentions_post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_post_mentions_post_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_post_mentions_post: ~0 rows (approximately)
/*!40000 ALTER TABLE `flarum_post_mentions_post` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_post_mentions_post` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_post_mentions_user
DROP TABLE IF EXISTS `flarum_post_mentions_user`;
CREATE TABLE IF NOT EXISTS `flarum_post_mentions_user` (
  `post_id` int unsigned NOT NULL,
  `mentions_user_id` int unsigned NOT NULL,
  PRIMARY KEY (`post_id`,`mentions_user_id`),
  KEY `flarum_post_mentions_user_mentions_user_id_foreign` (`mentions_user_id`),
  CONSTRAINT `flarum_post_mentions_user_mentions_user_id_foreign` FOREIGN KEY (`mentions_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_post_mentions_user_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_post_mentions_user: ~0 rows (approximately)
/*!40000 ALTER TABLE `flarum_post_mentions_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_post_mentions_user` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_post_reactions
DROP TABLE IF EXISTS `flarum_post_reactions`;
CREATE TABLE IF NOT EXISTS `flarum_post_reactions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `reaction_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `flarum_post_reactions_post_id_foreign` (`post_id`),
  KEY `flarum_post_reactions_user_id_foreign` (`user_id`),
  KEY `flarum_post_reactions_reaction_id_foreign` (`reaction_id`),
  CONSTRAINT `flarum_post_reactions_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_post_reactions_reaction_id_foreign` FOREIGN KEY (`reaction_id`) REFERENCES `flarum_reactions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_post_reactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_post_reactions: ~0 rows (approximately)
/*!40000 ALTER TABLE `flarum_post_reactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_post_reactions` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_post_user
DROP TABLE IF EXISTS `flarum_post_user`;
CREATE TABLE IF NOT EXISTS `flarum_post_user` (
  `post_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  PRIMARY KEY (`post_id`,`user_id`),
  KEY `flarum_post_user_user_id_foreign` (`user_id`),
  CONSTRAINT `flarum_post_user_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_post_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_post_user: ~0 rows (approximately)
/*!40000 ALTER TABLE `flarum_post_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_post_user` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_reactions
DROP TABLE IF EXISTS `flarum_reactions`;
CREATE TABLE IF NOT EXISTS `flarum_reactions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `display` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_reactions: ~6 rows (approximately)
/*!40000 ALTER TABLE `flarum_reactions` DISABLE KEYS */;
REPLACE INTO `flarum_reactions` (`id`, `identifier`, `type`, `enabled`, `display`) VALUES
	(1, 'thumbsup', 'emoji', 1, NULL),
	(2, 'thumbsdown', 'emoji', 1, NULL),
	(3, 'laughing', 'emoji', 1, NULL),
	(4, 'confused', 'emoji', 1, NULL),
	(5, 'heart', 'emoji', 1, NULL),
	(6, 'tada', 'emoji', 1, NULL);
/*!40000 ALTER TABLE `flarum_reactions` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_recipients
DROP TABLE IF EXISTS `flarum_recipients`;
CREATE TABLE IF NOT EXISTS `flarum_recipients` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `discussion_id` int unsigned DEFAULT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `group_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `removed_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `flarum_recipients_discussion_id_foreign` (`discussion_id`),
  KEY `flarum_recipients_user_id_foreign` (`user_id`),
  KEY `flarum_recipients_group_id_foreign` (`group_id`),
  KEY `flarum_recipients_removed_at_index` (`removed_at`),
  KEY `flarum_recipients_discussion_id_user_id_index` (`discussion_id`,`user_id`),
  KEY `flarum_recipients_discussion_id_group_id_index` (`discussion_id`,`group_id`),
  CONSTRAINT `flarum_recipients_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `flarum_discussions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_recipients_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `flarum_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_recipients_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_recipients: ~0 rows (approximately)
/*!40000 ALTER TABLE `flarum_recipients` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_recipients` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_registration_tokens
DROP TABLE IF EXISTS `flarum_registration_tokens`;
CREATE TABLE IF NOT EXISTS `flarum_registration_tokens` (
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `provider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_attributes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_registration_tokens: ~0 rows (approximately)
/*!40000 ALTER TABLE `flarum_registration_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_registration_tokens` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_settings
DROP TABLE IF EXISTS `flarum_settings`;
CREATE TABLE IF NOT EXISTS `flarum_settings` (
  `key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_settings: ~48 rows (approximately)
/*!40000 ALTER TABLE `flarum_settings` DISABLE KEYS */;
REPLACE INTO `flarum_settings` (`key`, `value`) VALUES
	('allow_post_editing', 'reply'),
	('allow_renaming', '10'),
	('allow_sign_up', '1'),
	('custom_less', ''),
	('davwheat-custom-sidenav-links.bottom-spacer', '1'),
	('davwheat-custom-sidenav-links.link-data', '[]'),
	('davwheat-custom-sidenav-links.position', 'above-tags-link'),
	('davwheat-custom-sidenav-links.top-spacer', '1'),
	('default_locale', 'en'),
	('default_route', '/all'),
	('extensions_enabled', '["flarum-flags","flarum-subscriptions","flarum-tags","flarum-approval","flarum-suspend","fof-impersonate","fof-follow-tags","davwheat-custom-sidenav-links","fof-upload","fof-split","fof-default-user-preferences","fof-byobu","fof-sitemap","fof-reactions","fof-best-answer","fof-profile-image-crop","fof-moderator-notes","fof-links","fof-ignore-users","fof-user-bio","fof-formatting","flarum-sticky","flarum-statistics","flarum-mentions","flarum-markdown","flarum-lock","flarum-lang-english","flarum-emoji","flarum-bbcode","ianm-follow-users"]'),
	('flarum-flags.can_flag_own', '1'),
	('flarum-flags.guidelines_url', ''),
	('flarum-markdown.mdarea', '1'),
	('flarum-mentions.allow_username_format', '1'),
	('flarum-tags.max_primary_tags', '1'),
	('flarum-tags.max_secondary_tags', '3'),
	('flarum-tags.min_primary_tags', '1'),
	('flarum-tags.min_secondary_tags', '0'),
	('fof-best-answer.allow_select_own_post', '1'),
	('fof-best-answer.remind_tag_ids', ''),
	('fof-best-answer.schedule_on_one_server', '0'),
	('fof-best-answer.select_best_answer_reminder_days', ''),
	('fof-best-answer.stop_overnight', '0'),
	('fof-best-answer.store_log_output', '0'),
	('fof-best-answer.use_alternative_ui', '1'),
	('fof-byobu.use_tag_slug', 'general'),
	('fof-formatting.plugin.autoimage', '1'),
	('fof-formatting.plugin.autovideo', '1'),
	('fof-formatting.plugin.fancypants', ''),
	('fof-formatting.plugin.htmlentities', ''),
	('fof-formatting.plugin.mediaembed', '1'),
	('fof-formatting.plugin.pipetables', '1'),
	('fof-sitemap.frequency', 'daily'),
	('fof-sitemap.mode', 'run'),
	('fof-user-bio.maxLength', '200'),
	('forum_description', 'This is a dockerised version of Flarum, intended for local development use only.'),
	('forum_title', 'Flarumite Dev'),
	('mail_driver', 'log'),
	('mail_from', 'noreply@localhost'),
	('slug_driver_Flarum\\User\\User', ''),
	('theme_colored_header', '0'),
	('theme_dark_mode', '0'),
	('theme_primary_color', '#4D698E'),
	('theme_secondary_color', '#4D698E'),
	('version', '1.0.1'),
	('welcome_message', 'This is a dockerised version of Flarum, intended for local development use only.'),
	('welcome_title', 'Welcome to Flarumite Dev');
/*!40000 ALTER TABLE `flarum_settings` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_tags
DROP TABLE IF EXISTS `flarum_tags`;
CREATE TABLE IF NOT EXISTS `flarum_tags` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `color` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `background_path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `background_mode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` int DEFAULT NULL,
  `parent_id` int unsigned DEFAULT NULL,
  `default_sort` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_restricted` tinyint(1) NOT NULL DEFAULT '0',
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0',
  `discussion_count` int unsigned NOT NULL DEFAULT '0',
  `last_posted_at` datetime DEFAULT NULL,
  `last_posted_discussion_id` int unsigned DEFAULT NULL,
  `last_posted_user_id` int unsigned DEFAULT NULL,
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `flarum_tags_slug_unique` (`slug`),
  KEY `flarum_tags_parent_id_foreign` (`parent_id`),
  KEY `flarum_tags_last_posted_user_id_foreign` (`last_posted_user_id`),
  KEY `flarum_tags_last_posted_discussion_id_foreign` (`last_posted_discussion_id`),
  CONSTRAINT `flarum_tags_last_posted_discussion_id_foreign` FOREIGN KEY (`last_posted_discussion_id`) REFERENCES `flarum_discussions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `flarum_tags_last_posted_user_id_foreign` FOREIGN KEY (`last_posted_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `flarum_tags_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `flarum_tags` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_tags: ~1 rows (approximately)
/*!40000 ALTER TABLE `flarum_tags` DISABLE KEYS */;
REPLACE INTO `flarum_tags` (`id`, `name`, `slug`, `description`, `color`, `background_path`, `background_mode`, `position`, `parent_id`, `default_sort`, `is_restricted`, `is_hidden`, `discussion_count`, `last_posted_at`, `last_posted_discussion_id`, `last_posted_user_id`, `icon`) VALUES
	(1, 'General', 'general', '', '#888', NULL, NULL, 0, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 'fas fa-comments');
/*!40000 ALTER TABLE `flarum_tags` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_tag_user
DROP TABLE IF EXISTS `flarum_tag_user`;
CREATE TABLE IF NOT EXISTS `flarum_tag_user` (
  `user_id` int unsigned NOT NULL,
  `tag_id` int unsigned NOT NULL,
  `marked_as_read_at` datetime DEFAULT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0',
  `subscription` enum('follow','lurk','ignore','hide') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`,`tag_id`),
  KEY `flarum_tag_user_tag_id_foreign` (`tag_id`),
  KEY `flarum_tag_user_user_id_subscription_index` (`user_id`,`subscription`),
  KEY `flarum_tag_user_subscription_index` (`subscription`),
  CONSTRAINT `flarum_tag_user_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `flarum_tags` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_tag_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_tag_user: ~0 rows (approximately)
/*!40000 ALTER TABLE `flarum_tag_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_tag_user` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_users
DROP TABLE IF EXISTS `flarum_users`;
CREATE TABLE IF NOT EXISTS `flarum_users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_email_confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bio` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `avatar_url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preferences` blob,
  `joined_at` datetime DEFAULT NULL,
  `last_seen_at` datetime DEFAULT NULL,
  `marked_all_as_read_at` datetime DEFAULT NULL,
  `read_notifications_at` datetime DEFAULT NULL,
  `discussion_count` int unsigned NOT NULL DEFAULT '0',
  `comment_count` int unsigned NOT NULL DEFAULT '0',
  `read_flags_at` datetime DEFAULT NULL,
  `suspended_until` datetime DEFAULT NULL,
  `blocks_byobu_pd` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `flarum_users_username_unique` (`username`),
  UNIQUE KEY `flarum_users_email_unique` (`email`),
  KEY `flarum_users_joined_at_index` (`joined_at`),
  KEY `flarum_users_last_seen_at_index` (`last_seen_at`),
  KEY `flarum_users_discussion_count_index` (`discussion_count`),
  KEY `flarum_users_comment_count_index` (`comment_count`),
  KEY `flarum_users_blocks_byobu_pd_index` (`blocks_byobu_pd`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_users: ~3 rows (approximately)
/*!40000 ALTER TABLE `flarum_users` DISABLE KEYS */;
REPLACE INTO `flarum_users` (`id`, `username`, `email`, `is_email_confirmed`, `password`, `bio`, `avatar_url`, `preferences`, `joined_at`, `last_seen_at`, `marked_all_as_read_at`, `read_notifications_at`, `discussion_count`, `comment_count`, `read_flags_at`, `suspended_until`, `blocks_byobu_pd`) VALUES
	(1, 'flarumite', 'flarumite@flarumite.com', 1, '$2y$10$KIEe2Wc87aWWlTnvtmeVPOAw1M/FFmFgEetle8BoL7tvw4w0kCDm.', NULL, NULL, NULL, '2020-05-09 22:08:27', '2021-06-03 19:49:46', NULL, NULL, 0, 0, NULL, NULL, 0),
	(2, 'moderator', 'moderator@flarumite.com', 1, '$2y$10$oChGVhEf2vIMxTN6iwOA.O6lZqv5SrYTenUZANs81fjzxCpw5WRoW', NULL, NULL, _binary 0x7B22626C6F636B735064223A66616C73652C226E6F746966795F64697363757373696F6E52656E616D65645F616C657274223A747275652C226E6F746966795F64697363757373696F6E4C6F636B65645F616C657274223A747275652C226E6F746966795F706F73744D656E74696F6E65645F616C657274223A747275652C226E6F746966795F706F73744D656E74696F6E65645F656D61696C223A747275652C226E6F746966795F757365724D656E74696F6E65645F616C657274223A747275652C226E6F746966795F757365724D656E74696F6E65645F656D61696C223A747275652C226E6F746966795F6E6577506F73745F616C657274223A747275652C226E6F746966795F6E6577506F73745F656D61696C223A747275652C226E6F746966795F7573657253757370656E6465645F616C657274223A747275652C226E6F746966795F75736572556E73757370656E6465645F616C657274223A747275652C226E6F746966795F73656C65637442657374416E737765725F616C657274223A747275652C226E6F746966795F73656C65637442657374416E737765725F656D61696C223A747275652C226E6F746966795F6177617264656442657374416E737765725F616C657274223A747275652C226E6F746966795F6177617264656442657374416E737765725F656D61696C223A66616C73652C226E6F746966795F62657374416E73776572496E44697363757373696F6E5F616C657274223A66616C73652C226E6F746966795F62657374416E73776572496E44697363757373696F6E5F656D61696C223A66616C73652C226E6F746966795F706F7374526561637465645F616C657274223A747275652C226E6F746966795F62796F62755072697661746544697363757373696F6E437265617465645F616C657274223A747275652C226E6F746966795F62796F62755072697661746544697363757373696F6E437265617465645F656D61696C223A747275652C226E6F746966795F62796F62755072697661746544697363757373696F6E5265706C6965645F616C657274223A747275652C226E6F746966795F62796F62755072697661746544697363757373696F6E5265706C6965645F656D61696C223A747275652C226E6F746966795F62796F6275526563697069656E7452656D6F7665645F616C657274223A747275652C226E6F746966795F62796F6275526563697069656E7452656D6F7665645F656D61696C223A747275652C226E6F746966795F62796F62755072697661746544697363757373696F6E41646465645F616C657274223A747275652C226E6F746966795F62796F62755072697661746544697363757373696F6E41646465645F656D61696C223A747275652C226E6F746966795F6E657744697363757373696F6E496E5461675F616C657274223A747275652C226E6F746966795F6E657744697363757373696F6E496E5461675F656D61696C223A747275652C226E6F746966795F6E6577506F7374496E5461675F616C657274223A747275652C226E6F746966795F6E6577506F7374496E5461675F656D61696C223A747275652C22666F6C6C6F7741667465725265706C79223A747275652C22646973636C6F73654F6E6C696E65223A747275652C22696E64657850726F66696C65223A747275652C226C6F63616C65223A6E756C6C7D, '2020-05-10 15:41:58', '2020-05-10 15:42:57', NULL, NULL, 0, 0, NULL, NULL, 0),
	(3, 'user', 'user@flarumite.com', 1, '$2y$10$.Bd1QaM2iVW5qaONc0KQW.bN9V1k98A2aSCE5UKxpi6DUylvXZ9hK', NULL, NULL, _binary 0x7B22626C6F636B735064223A66616C73652C226E6F746966795F64697363757373696F6E52656E616D65645F616C657274223A747275652C226E6F746966795F64697363757373696F6E4C6F636B65645F616C657274223A747275652C226E6F746966795F706F73744D656E74696F6E65645F616C657274223A747275652C226E6F746966795F706F73744D656E74696F6E65645F656D61696C223A747275652C226E6F746966795F757365724D656E74696F6E65645F616C657274223A747275652C226E6F746966795F757365724D656E74696F6E65645F656D61696C223A747275652C226E6F746966795F6E6577506F73745F616C657274223A747275652C226E6F746966795F6E6577506F73745F656D61696C223A747275652C226E6F746966795F7573657253757370656E6465645F616C657274223A747275652C226E6F746966795F75736572556E73757370656E6465645F616C657274223A747275652C226E6F746966795F73656C65637442657374416E737765725F616C657274223A747275652C226E6F746966795F73656C65637442657374416E737765725F656D61696C223A747275652C226E6F746966795F6177617264656442657374416E737765725F616C657274223A747275652C226E6F746966795F6177617264656442657374416E737765725F656D61696C223A66616C73652C226E6F746966795F62657374416E73776572496E44697363757373696F6E5F616C657274223A66616C73652C226E6F746966795F62657374416E73776572496E44697363757373696F6E5F656D61696C223A66616C73652C226E6F746966795F706F7374526561637465645F616C657274223A747275652C226E6F746966795F62796F62755072697661746544697363757373696F6E437265617465645F616C657274223A747275652C226E6F746966795F62796F62755072697661746544697363757373696F6E437265617465645F656D61696C223A747275652C226E6F746966795F62796F62755072697661746544697363757373696F6E5265706C6965645F616C657274223A747275652C226E6F746966795F62796F62755072697661746544697363757373696F6E5265706C6965645F656D61696C223A747275652C226E6F746966795F62796F6275526563697069656E7452656D6F7665645F616C657274223A747275652C226E6F746966795F62796F6275526563697069656E7452656D6F7665645F656D61696C223A747275652C226E6F746966795F62796F62755072697661746544697363757373696F6E41646465645F616C657274223A747275652C226E6F746966795F62796F62755072697661746544697363757373696F6E41646465645F656D61696C223A747275652C226E6F746966795F6E657744697363757373696F6E496E5461675F616C657274223A747275652C226E6F746966795F6E657744697363757373696F6E496E5461675F656D61696C223A747275652C226E6F746966795F6E6577506F7374496E5461675F616C657274223A747275652C226E6F746966795F6E6577506F7374496E5461675F656D61696C223A747275652C22666F6C6C6F7741667465725265706C79223A747275652C22646973636C6F73654F6E6C696E65223A747275652C22696E64657850726F66696C65223A747275652C226C6F63616C65223A6E756C6C7D, '2020-05-10 15:44:12', '2020-05-10 15:44:29', NULL, NULL, 0, 0, NULL, NULL, 0);
/*!40000 ALTER TABLE `flarum_users` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_users_notes
DROP TABLE IF EXISTS `flarum_users_notes`;
CREATE TABLE IF NOT EXISTS `flarum_users_notes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `note` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `added_by_user_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `flarum_users_notes_added_by_user_id_foreign` (`added_by_user_id`),
  CONSTRAINT `flarum_users_notes_added_by_user_id_foreign` FOREIGN KEY (`added_by_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `flarum_users_notes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_users_notes: ~0 rows (approximately)
/*!40000 ALTER TABLE `flarum_users_notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_users_notes` ENABLE KEYS */;

-- Dumping structure for table flarum.flarum_user_followers
DROP TABLE IF EXISTS `flarum_user_followers`;
CREATE TABLE IF NOT EXISTS `flarum_user_followers` (
  `user_id` int unsigned NOT NULL,
  `followed_user_id` int unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`,`followed_user_id`),
  KEY `flarum_user_followers_followed_user_id_foreign` (`followed_user_id`),
  CONSTRAINT `flarum_user_followers_followed_user_id_foreign` FOREIGN KEY (`followed_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_user_followers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table flarum.flarum_user_followers: ~0 rows (approximately)
/*!40000 ALTER TABLE `flarum_user_followers` DISABLE KEYS */;
/*!40000 ALTER TABLE `flarum_user_followers` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
