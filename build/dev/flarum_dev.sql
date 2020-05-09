# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.29-32)
# Database: flarum
# Generation Time: 2020-05-09 22:24:46 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table flarum_access_tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flarum_access_tokens`;

CREATE TABLE `flarum_access_tokens` (
  `token` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `last_activity_at` datetime NOT NULL,
  `lifetime_seconds` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`token`),
  KEY `flarum_access_tokens_user_id_foreign` (`user_id`),
  CONSTRAINT `flarum_access_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table flarum_api_keys
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flarum_api_keys`;

CREATE TABLE `flarum_api_keys` (
  `key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `allowed_ips` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `last_activity_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `flarum_api_keys_key_unique` (`key`),
  KEY `flarum_api_keys_user_id_foreign` (`user_id`),
  CONSTRAINT `flarum_api_keys_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table flarum_discussion_tag
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flarum_discussion_tag`;

CREATE TABLE `flarum_discussion_tag` (
  `discussion_id` int(10) unsigned NOT NULL,
  `tag_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`discussion_id`,`tag_id`),
  KEY `flarum_discussion_tag_tag_id_foreign` (`tag_id`),
  CONSTRAINT `flarum_discussion_tag_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `flarum_discussions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_discussion_tag_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `flarum_tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table flarum_discussion_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flarum_discussion_user`;

CREATE TABLE `flarum_discussion_user` (
  `user_id` int(10) unsigned NOT NULL,
  `discussion_id` int(10) unsigned NOT NULL,
  `last_read_at` datetime DEFAULT NULL,
  `last_read_post_number` int(10) unsigned DEFAULT NULL,
  `subscription` enum('follow','ignore') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`,`discussion_id`),
  KEY `flarum_discussion_user_discussion_id_foreign` (`discussion_id`),
  CONSTRAINT `flarum_discussion_user_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `flarum_discussions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_discussion_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table flarum_discussions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flarum_discussions`;

CREATE TABLE `flarum_discussions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment_count` int(11) NOT NULL DEFAULT '1',
  `participant_count` int(10) unsigned NOT NULL DEFAULT '0',
  `post_number_index` int(10) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `first_post_id` int(10) unsigned DEFAULT NULL,
  `last_posted_at` datetime DEFAULT NULL,
  `last_posted_user_id` int(10) unsigned DEFAULT NULL,
  `last_post_id` int(10) unsigned DEFAULT NULL,
  `last_post_number` int(10) unsigned DEFAULT NULL,
  `hidden_at` datetime DEFAULT NULL,
  `hidden_user_id` int(10) unsigned DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  `is_approved` tinyint(1) NOT NULL DEFAULT '1',
  `is_locked` tinyint(1) NOT NULL DEFAULT '0',
  `is_sticky` tinyint(1) NOT NULL DEFAULT '0',
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
  FULLTEXT KEY `title` (`title`),
  CONSTRAINT `flarum_discussions_first_post_id_foreign` FOREIGN KEY (`first_post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `flarum_discussions_hidden_user_id_foreign` FOREIGN KEY (`hidden_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `flarum_discussions_last_post_id_foreign` FOREIGN KEY (`last_post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `flarum_discussions_last_posted_user_id_foreign` FOREIGN KEY (`last_posted_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `flarum_discussions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table flarum_email_tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flarum_email_tokens`;

CREATE TABLE `flarum_email_tokens` (
  `token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`token`),
  KEY `flarum_email_tokens_user_id_foreign` (`user_id`),
  CONSTRAINT `flarum_email_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table flarum_flags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flarum_flags`;

CREATE TABLE `flarum_flags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(10) unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reason_detail` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `flarum_flags_post_id_foreign` (`post_id`),
  KEY `flarum_flags_user_id_foreign` (`user_id`),
  KEY `flarum_flags_created_at_index` (`created_at`),
  CONSTRAINT `flarum_flags_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_flags_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table flarum_group_permission
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flarum_group_permission`;

CREATE TABLE `flarum_group_permission` (
  `group_id` int(10) unsigned NOT NULL,
  `permission` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`group_id`,`permission`),
  CONSTRAINT `flarum_group_permission_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `flarum_groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `flarum_group_permission` WRITE;
/*!40000 ALTER TABLE `flarum_group_permission` DISABLE KEYS */;

INSERT INTO `flarum_group_permission` (`group_id`, `permission`)
VALUES
	(2,'viewDiscussions'),
	(3,'discussion.flagPosts'),
	(3,'discussion.likePosts'),
	(3,'discussion.reply'),
	(3,'discussion.replyWithoutApproval'),
	(3,'discussion.startWithoutApproval'),
	(3,'startDiscussion'),
	(3,'viewUserList'),
	(4,'discussion.approvePosts'),
	(4,'discussion.editPosts'),
	(4,'discussion.hide'),
	(4,'discussion.hidePosts'),
	(4,'discussion.lock'),
	(4,'discussion.rename'),
	(4,'discussion.sticky'),
	(4,'discussion.tag'),
	(4,'discussion.viewFlags'),
	(4,'discussion.viewIpsPosts'),
	(4,'user.suspend'),
	(4,'user.viewLastSeenAt');

/*!40000 ALTER TABLE `flarum_group_permission` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table flarum_group_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flarum_group_user`;

CREATE TABLE `flarum_group_user` (
  `user_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`group_id`),
  KEY `flarum_group_user_group_id_foreign` (`group_id`),
  CONSTRAINT `flarum_group_user_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `flarum_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_group_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `flarum_group_user` WRITE;
/*!40000 ALTER TABLE `flarum_group_user` DISABLE KEYS */;

INSERT INTO `flarum_group_user` (`user_id`, `group_id`)
VALUES
	(1,1);

/*!40000 ALTER TABLE `flarum_group_user` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table flarum_groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flarum_groups`;

CREATE TABLE `flarum_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name_singular` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_plural` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `flarum_groups` WRITE;
/*!40000 ALTER TABLE `flarum_groups` DISABLE KEYS */;

INSERT INTO `flarum_groups` (`id`, `name_singular`, `name_plural`, `color`, `icon`, `is_hidden`)
VALUES
	(1,'Admin','Admins','#B72A2A','fas fa-wrench',0),
	(2,'Guest','Guests',NULL,NULL,0),
	(3,'Member','Members',NULL,NULL,0),
	(4,'Mod','Mods','#80349E','fas fa-bolt',0);

/*!40000 ALTER TABLE `flarum_groups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table flarum_login_providers
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flarum_login_providers`;

CREATE TABLE `flarum_login_providers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `provider` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `identifier` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `flarum_login_providers_provider_identifier_unique` (`provider`,`identifier`),
  KEY `flarum_login_providers_user_id_foreign` (`user_id`),
  CONSTRAINT `flarum_login_providers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table flarum_migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flarum_migrations`;

CREATE TABLE `flarum_migrations` (
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `extension` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `flarum_migrations` WRITE;
/*!40000 ALTER TABLE `flarum_migrations` DISABLE KEYS */;

INSERT INTO `flarum_migrations` (`migration`, `extension`)
VALUES
	('2015_02_24_000000_create_access_tokens_table',NULL),
	('2015_02_24_000000_create_api_keys_table',NULL),
	('2015_02_24_000000_create_config_table',NULL),
	('2015_02_24_000000_create_discussions_table',NULL),
	('2015_02_24_000000_create_email_tokens_table',NULL),
	('2015_02_24_000000_create_groups_table',NULL),
	('2015_02_24_000000_create_notifications_table',NULL),
	('2015_02_24_000000_create_password_tokens_table',NULL),
	('2015_02_24_000000_create_permissions_table',NULL),
	('2015_02_24_000000_create_posts_table',NULL),
	('2015_02_24_000000_create_users_discussions_table',NULL),
	('2015_02_24_000000_create_users_groups_table',NULL),
	('2015_02_24_000000_create_users_table',NULL),
	('2015_09_15_000000_create_auth_tokens_table',NULL),
	('2015_09_20_224327_add_hide_to_discussions',NULL),
	('2015_09_22_030432_rename_notification_read_time',NULL),
	('2015_10_07_130531_rename_config_to_settings',NULL),
	('2015_10_24_194000_add_ip_address_to_posts',NULL),
	('2015_12_05_042721_change_access_tokens_columns',NULL),
	('2015_12_17_194247_change_settings_value_column_to_text',NULL),
	('2016_02_04_095452_add_slug_to_discussions',NULL),
	('2017_04_07_114138_add_is_private_to_discussions',NULL),
	('2017_04_07_114138_add_is_private_to_posts',NULL),
	('2018_01_11_093900_change_access_tokens_columns',NULL),
	('2018_01_11_094000_change_access_tokens_add_foreign_keys',NULL),
	('2018_01_11_095000_change_api_keys_columns',NULL),
	('2018_01_11_101800_rename_auth_tokens_to_registration_tokens',NULL),
	('2018_01_11_102000_change_registration_tokens_rename_id_to_token',NULL),
	('2018_01_11_102100_change_registration_tokens_created_at_to_datetime',NULL),
	('2018_01_11_120604_change_posts_table_to_innodb',NULL),
	('2018_01_11_155200_change_discussions_rename_columns',NULL),
	('2018_01_11_155300_change_discussions_add_foreign_keys',NULL),
	('2018_01_15_071700_rename_users_discussions_to_discussion_user',NULL),
	('2018_01_15_071800_change_discussion_user_rename_columns',NULL),
	('2018_01_15_071900_change_discussion_user_add_foreign_keys',NULL),
	('2018_01_15_072600_change_email_tokens_rename_id_to_token',NULL),
	('2018_01_15_072700_change_email_tokens_add_foreign_keys',NULL),
	('2018_01_15_072800_change_email_tokens_created_at_to_datetime',NULL),
	('2018_01_18_130400_rename_permissions_to_group_permission',NULL),
	('2018_01_18_130500_change_group_permission_add_foreign_keys',NULL),
	('2018_01_18_130600_rename_users_groups_to_group_user',NULL),
	('2018_01_18_130700_change_group_user_add_foreign_keys',NULL),
	('2018_01_18_133000_change_notifications_columns',NULL),
	('2018_01_18_133100_change_notifications_add_foreign_keys',NULL),
	('2018_01_18_134400_change_password_tokens_rename_id_to_token',NULL),
	('2018_01_18_134500_change_password_tokens_add_foreign_keys',NULL),
	('2018_01_18_134600_change_password_tokens_created_at_to_datetime',NULL),
	('2018_01_18_135000_change_posts_rename_columns',NULL),
	('2018_01_18_135100_change_posts_add_foreign_keys',NULL),
	('2018_01_30_112238_add_fulltext_index_to_discussions_title',NULL),
	('2018_01_30_220100_create_post_user_table',NULL),
	('2018_01_30_222900_change_users_rename_columns',NULL),
	('2018_07_21_000000_seed_default_groups',NULL),
	('2018_07_21_000100_seed_default_group_permissions',NULL),
	('2018_09_15_041340_add_users_indicies',NULL),
	('2018_09_15_041828_add_discussions_indicies',NULL),
	('2018_09_15_043337_add_notifications_indices',NULL),
	('2018_09_15_043621_add_posts_indices',NULL),
	('2018_09_22_004100_change_registration_tokens_columns',NULL),
	('2018_09_22_004200_create_login_providers_table',NULL),
	('2018_10_08_144700_add_shim_prefix_to_group_icons',NULL),
	('2019_06_24_145100_change_posts_content_column_to_mediumtext',NULL),
	('2019_10_12_195349_change_posts_add_discussion_foreign_key',NULL),
	('2020_03_19_134512_change_discussions_default_comment_count',NULL),
	('2020_04_21_130500_change_permission_groups_add_is_hidden',NULL),
	('2015_09_21_011527_add_is_approved_to_discussions','flarum-approval'),
	('2015_09_21_011706_add_is_approved_to_posts','flarum-approval'),
	('2017_07_22_000000_add_default_permissions','flarum-approval'),
	('2018_09_29_060444_replace_emoji_shorcuts_with_unicode','flarum-emoji'),
	('2015_09_02_000000_add_flags_read_time_to_users_table','flarum-flags'),
	('2015_09_02_000000_create_flags_table','flarum-flags'),
	('2017_07_22_000000_add_default_permissions','flarum-flags'),
	('2018_06_27_101500_change_flags_rename_time_to_created_at','flarum-flags'),
	('2018_06_27_101600_change_flags_add_foreign_keys','flarum-flags'),
	('2018_06_27_105100_change_users_rename_flags_read_time_to_read_flags_at','flarum-flags'),
	('2018_09_15_043621_add_flags_indices','flarum-flags'),
	('2019_10_22_000000_change_reason_text_col_type','flarum-flags'),
	('2015_05_11_000000_create_posts_likes_table','flarum-likes'),
	('2015_09_04_000000_add_default_like_permissions','flarum-likes'),
	('2018_06_27_100600_rename_posts_likes_to_post_likes','flarum-likes'),
	('2018_06_27_100700_change_post_likes_add_foreign_keys','flarum-likes'),
	('2015_02_24_000000_add_locked_to_discussions','flarum-lock'),
	('2017_07_22_000000_add_default_permissions','flarum-lock'),
	('2018_09_15_043621_add_discussions_indices','flarum-lock'),
	('2015_05_11_000000_create_mentions_posts_table','flarum-mentions'),
	('2015_05_11_000000_create_mentions_users_table','flarum-mentions'),
	('2018_06_27_102000_rename_mentions_posts_to_post_mentions_post','flarum-mentions'),
	('2018_06_27_102100_rename_mentions_users_to_post_mentions_user','flarum-mentions'),
	('2018_06_27_102200_change_post_mentions_post_rename_mentions_id_to_mentions_post_id','flarum-mentions'),
	('2018_06_27_102300_change_post_mentions_post_add_foreign_keys','flarum-mentions'),
	('2018_06_27_102400_change_post_mentions_user_rename_mentions_id_to_mentions_user_id','flarum-mentions'),
	('2018_06_27_102500_change_post_mentions_user_add_foreign_keys','flarum-mentions'),
	('2015_02_24_000000_add_sticky_to_discussions','flarum-sticky'),
	('2017_07_22_000000_add_default_permissions','flarum-sticky'),
	('2018_09_15_043621_add_discussions_indices','flarum-sticky'),
	('2015_05_11_000000_add_subscription_to_users_discussions_table','flarum-subscriptions'),
	('2015_05_11_000000_add_suspended_until_to_users_table','flarum-suspend'),
	('2015_09_14_000000_rename_suspended_until_column','flarum-suspend'),
	('2017_07_22_000000_add_default_permissions','flarum-suspend'),
	('2018_06_27_111400_change_users_rename_suspend_until_to_suspended_until','flarum-suspend'),
	('2015_02_24_000000_create_discussions_tags_table','flarum-tags'),
	('2015_02_24_000000_create_tags_table','flarum-tags'),
	('2015_02_24_000000_create_users_tags_table','flarum-tags'),
	('2015_02_24_000000_set_default_settings','flarum-tags'),
	('2015_10_19_061223_make_slug_unique','flarum-tags'),
	('2017_07_22_000000_add_default_permissions','flarum-tags'),
	('2018_06_27_085200_change_tags_columns','flarum-tags'),
	('2018_06_27_085300_change_tags_add_foreign_keys','flarum-tags'),
	('2018_06_27_090400_rename_users_tags_to_tag_user','flarum-tags'),
	('2018_06_27_100100_change_tag_user_rename_read_time_to_marked_as_read_at','flarum-tags'),
	('2018_06_27_100200_change_tag_user_add_foreign_keys','flarum-tags'),
	('2018_06_27_103000_rename_discussions_tags_to_discussion_tag','flarum-tags'),
	('2018_06_27_103100_add_discussion_tag_foreign_keys','flarum-tags'),
	('2019_04_21_000000_add_icon_to_tags_table','flarum-tags');

/*!40000 ALTER TABLE `flarum_migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table flarum_notifications
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flarum_notifications`;

CREATE TABLE `flarum_notifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `from_user_id` int(10) unsigned DEFAULT NULL,
  `type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_id` int(10) unsigned DEFAULT NULL,
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



# Dump of table flarum_password_tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flarum_password_tokens`;

CREATE TABLE `flarum_password_tokens` (
  `token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`token`),
  KEY `flarum_password_tokens_user_id_foreign` (`user_id`),
  CONSTRAINT `flarum_password_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table flarum_post_likes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flarum_post_likes`;

CREATE TABLE `flarum_post_likes` (
  `post_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`post_id`,`user_id`),
  KEY `flarum_post_likes_user_id_foreign` (`user_id`),
  CONSTRAINT `flarum_post_likes_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_post_likes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table flarum_post_mentions_post
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flarum_post_mentions_post`;

CREATE TABLE `flarum_post_mentions_post` (
  `post_id` int(10) unsigned NOT NULL,
  `mentions_post_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`post_id`,`mentions_post_id`),
  KEY `flarum_post_mentions_post_mentions_post_id_foreign` (`mentions_post_id`),
  CONSTRAINT `flarum_post_mentions_post_mentions_post_id_foreign` FOREIGN KEY (`mentions_post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_post_mentions_post_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table flarum_post_mentions_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flarum_post_mentions_user`;

CREATE TABLE `flarum_post_mentions_user` (
  `post_id` int(10) unsigned NOT NULL,
  `mentions_user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`post_id`,`mentions_user_id`),
  KEY `flarum_post_mentions_user_mentions_user_id_foreign` (`mentions_user_id`),
  CONSTRAINT `flarum_post_mentions_user_mentions_user_id_foreign` FOREIGN KEY (`mentions_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_post_mentions_user_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table flarum_post_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flarum_post_user`;

CREATE TABLE `flarum_post_user` (
  `post_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`post_id`,`user_id`),
  KEY `flarum_post_user_user_id_foreign` (`user_id`),
  CONSTRAINT `flarum_post_user_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_post_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table flarum_posts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flarum_posts`;

CREATE TABLE `flarum_posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `discussion_id` int(10) unsigned NOT NULL,
  `number` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` mediumtext COLLATE utf8mb4_unicode_ci COMMENT ' ',
  `edited_at` datetime DEFAULT NULL,
  `edited_user_id` int(10) unsigned DEFAULT NULL,
  `hidden_at` datetime DEFAULT NULL,
  `hidden_user_id` int(10) unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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



# Dump of table flarum_registration_tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flarum_registration_tokens`;

CREATE TABLE `flarum_registration_tokens` (
  `token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `identifier` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_attributes` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table flarum_settings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flarum_settings`;

CREATE TABLE `flarum_settings` (
  `key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `flarum_settings` WRITE;
/*!40000 ALTER TABLE `flarum_settings` DISABLE KEYS */;

INSERT INTO `flarum_settings` (`key`, `value`)
VALUES
	('allow_post_editing','reply'),
	('allow_renaming','10'),
	('allow_sign_up','1'),
	('custom_less',''),
	('default_locale','en'),
	('default_route','/all'),
	('extensions_enabled','[\"flarum-approval\",\"flarum-bbcode\",\"flarum-emoji\",\"flarum-lang-english\",\"flarum-flags\",\"flarum-likes\",\"flarum-lock\",\"flarum-markdown\",\"flarum-mentions\",\"flarum-statistics\",\"flarum-sticky\",\"flarum-subscriptions\",\"flarum-suspend\",\"flarum-tags\"]'),
	('flarum-tags.max_primary_tags','1'),
	('flarum-tags.max_secondary_tags','3'),
	('flarum-tags.min_primary_tags','1'),
	('flarum-tags.min_secondary_tags','0'),
	('forum_description',''),
	('forum_title','Flarumite Dev'),
	('mail_driver','log'),
	('mail_from','noreply@localhost'),
	('theme_colored_header','0'),
	('theme_dark_mode','0'),
	('theme_primary_color','#4D698E'),
	('theme_secondary_color','#4D698E'),
	('version','0.1.0-beta.13'),
	('welcome_message','This is beta software and you should not use it in production.'),
	('welcome_title','Welcome to Flarumite Dev');

/*!40000 ALTER TABLE `flarum_settings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table flarum_tag_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flarum_tag_user`;

CREATE TABLE `flarum_tag_user` (
  `user_id` int(10) unsigned NOT NULL,
  `tag_id` int(10) unsigned NOT NULL,
  `marked_as_read_at` datetime DEFAULT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`tag_id`),
  KEY `flarum_tag_user_tag_id_foreign` (`tag_id`),
  CONSTRAINT `flarum_tag_user_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `flarum_tags` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flarum_tag_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



# Dump of table flarum_tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flarum_tags`;

CREATE TABLE `flarum_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `color` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `background_path` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `background_mode` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `default_sort` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_restricted` tinyint(1) NOT NULL DEFAULT '0',
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0',
  `discussion_count` int(10) unsigned NOT NULL DEFAULT '0',
  `last_posted_at` datetime DEFAULT NULL,
  `last_posted_discussion_id` int(10) unsigned DEFAULT NULL,
  `last_posted_user_id` int(10) unsigned DEFAULT NULL,
  `icon` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `flarum_tags_slug_unique` (`slug`),
  KEY `flarum_tags_parent_id_foreign` (`parent_id`),
  KEY `flarum_tags_last_posted_user_id_foreign` (`last_posted_user_id`),
  KEY `flarum_tags_last_posted_discussion_id_foreign` (`last_posted_discussion_id`),
  CONSTRAINT `flarum_tags_last_posted_discussion_id_foreign` FOREIGN KEY (`last_posted_discussion_id`) REFERENCES `flarum_discussions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `flarum_tags_last_posted_user_id_foreign` FOREIGN KEY (`last_posted_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `flarum_tags_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `flarum_tags` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `flarum_tags` WRITE;
/*!40000 ALTER TABLE `flarum_tags` DISABLE KEYS */;

INSERT INTO `flarum_tags` (`id`, `name`, `slug`, `description`, `color`, `background_path`, `background_mode`, `position`, `parent_id`, `default_sort`, `is_restricted`, `is_hidden`, `discussion_count`, `last_posted_at`, `last_posted_discussion_id`, `last_posted_user_id`, `icon`)
VALUES
	(1,'General','general',NULL,'#888',NULL,NULL,0,NULL,NULL,0,0,0,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `flarum_tags` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table flarum_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `flarum_users`;

CREATE TABLE `flarum_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_email_confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `password` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bio` text COLLATE utf8mb4_unicode_ci,
  `avatar_url` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preferences` blob,
  `joined_at` datetime DEFAULT NULL,
  `last_seen_at` datetime DEFAULT NULL,
  `marked_all_as_read_at` datetime DEFAULT NULL,
  `read_notifications_at` datetime DEFAULT NULL,
  `discussion_count` int(10) unsigned NOT NULL DEFAULT '0',
  `comment_count` int(10) unsigned NOT NULL DEFAULT '0',
  `read_flags_at` datetime DEFAULT NULL,
  `suspended_until` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `flarum_users_username_unique` (`username`),
  UNIQUE KEY `flarum_users_email_unique` (`email`),
  KEY `flarum_users_joined_at_index` (`joined_at`),
  KEY `flarum_users_last_seen_at_index` (`last_seen_at`),
  KEY `flarum_users_discussion_count_index` (`discussion_count`),
  KEY `flarum_users_comment_count_index` (`comment_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `flarum_users` WRITE;
/*!40000 ALTER TABLE `flarum_users` DISABLE KEYS */;

INSERT INTO `flarum_users` (`id`, `username`, `email`, `is_email_confirmed`, `password`, `bio`, `avatar_url`, `preferences`, `joined_at`, `last_seen_at`, `marked_all_as_read_at`, `read_notifications_at`, `discussion_count`, `comment_count`, `read_flags_at`, `suspended_until`)
VALUES
	(1,'flarumite','flarumite@flarumite.com',1,'$2y$10$KIEe2Wc87aWWlTnvtmeVPOAw1M/FFmFgEetle8BoL7tvw4w0kCDm.',NULL,NULL,NULL,'2020-05-09 22:08:27','2020-05-09 22:22:52',NULL,NULL,0,0,NULL,NULL);

/*!40000 ALTER TABLE `flarum_users` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
