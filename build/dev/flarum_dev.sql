-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: flarumdb
-- Generation Time: Dec 21, 2020 at 02:29 PM
-- Server version: 8.0.22
-- PHP Version: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `flarum`
--

-- --------------------------------------------------------

--
-- Table structure for table `flarum_access_tokens`
--

CREATE TABLE `flarum_access_tokens` (
  `token` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `last_activity_at` datetime NOT NULL,
  `lifetime_seconds` int NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flarum_access_tokens`
--

INSERT INTO `flarum_access_tokens` (`token`, `user_id`, `last_activity_at`, `lifetime_seconds`, `created_at`) VALUES
('88oK4VsSdTW54Z3WpccPiI1PlzTv7LsV49WsSwLQ', 1, '2020-12-21 14:26:26', 3600, '2020-12-21 14:26:26'),
('hEzHV44qOizFBaaYU1cCRCC89YxFe4gqej9fLHoO', 3, '2020-05-10 15:44:29', 157680000, '2020-05-10 15:44:12');

-- --------------------------------------------------------

--
-- Table structure for table `flarum_api_keys`
--

CREATE TABLE `flarum_api_keys` (
  `key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id` int UNSIGNED NOT NULL,
  `allowed_ips` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `last_activity_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flarum_decontaminator`
--

CREATE TABLE `flarum_decontaminator` (
  `id` int UNSIGNED NOT NULL,
  `type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `flag` tinyint(1) NOT NULL,
  `event` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `replacement` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` datetime NOT NULL,
  `edit_time` datetime DEFAULT NULL,
  `regex` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flarum_decontaminator`
--

INSERT INTO `flarum_decontaminator` (`id`, `type`, `name`, `flag`, `event`, `replacement`, `time`, `edit_time`, `regex`) VALUES
(1, '', 'Example: Wibble', 1, 'save', '<censored>', '2020-05-10 14:42:44', NULL, '/wibble/mi');

-- --------------------------------------------------------

--
-- Table structure for table `flarum_discussions`
--

CREATE TABLE `flarum_discussions` (
  `id` int UNSIGNED NOT NULL,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment_count` int NOT NULL DEFAULT '1',
  `participant_count` int UNSIGNED NOT NULL DEFAULT '0',
  `post_number_index` int UNSIGNED NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `user_id` int UNSIGNED DEFAULT NULL,
  `first_post_id` int UNSIGNED DEFAULT NULL,
  `last_posted_at` datetime DEFAULT NULL,
  `last_posted_user_id` int UNSIGNED DEFAULT NULL,
  `last_post_id` int UNSIGNED DEFAULT NULL,
  `last_post_number` int UNSIGNED DEFAULT NULL,
  `hidden_at` datetime DEFAULT NULL,
  `hidden_user_id` int UNSIGNED DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  `is_approved` tinyint(1) NOT NULL DEFAULT '1',
  `is_locked` tinyint(1) NOT NULL DEFAULT '0',
  `is_sticky` tinyint(1) NOT NULL DEFAULT '0',
  `best_answer_post_id` int UNSIGNED DEFAULT NULL,
  `best_answer_user_id` int UNSIGNED DEFAULT NULL,
  `best_answer_notified` tinyint(1) NOT NULL,
  `best_answer_set_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flarum_discussion_tag`
--

CREATE TABLE `flarum_discussion_tag` (
  `discussion_id` int UNSIGNED NOT NULL,
  `tag_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flarum_discussion_user`
--

CREATE TABLE `flarum_discussion_user` (
  `user_id` int UNSIGNED NOT NULL,
  `discussion_id` int UNSIGNED NOT NULL,
  `last_read_at` datetime DEFAULT NULL,
  `last_read_post_number` int UNSIGNED DEFAULT NULL,
  `subscription` enum('follow','ignore') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flarum_email_tokens`
--

CREATE TABLE `flarum_email_tokens` (
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flarum_flags`
--

CREATE TABLE `flarum_flags` (
  `id` int UNSIGNED NOT NULL,
  `post_id` int UNSIGNED NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int UNSIGNED DEFAULT NULL,
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reason_detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flarum_fof_upload_downloads`
--

CREATE TABLE `flarum_fof_upload_downloads` (
  `id` bigint UNSIGNED NOT NULL,
  `file_id` int UNSIGNED NOT NULL,
  `discussion_id` int UNSIGNED DEFAULT NULL,
  `post_id` int UNSIGNED DEFAULT NULL,
  `actor_id` int UNSIGNED DEFAULT NULL,
  `downloaded_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flarum_fof_upload_files`
--

CREATE TABLE `flarum_fof_upload_files` (
  `id` int UNSIGNED NOT NULL,
  `actor_id` int UNSIGNED DEFAULT NULL,
  `discussion_id` int UNSIGNED DEFAULT NULL,
  `post_id` int UNSIGNED DEFAULT NULL,
  `base_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` int NOT NULL,
  `upload_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `remote_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flarum_groups`
--

CREATE TABLE `flarum_groups` (
  `id` int UNSIGNED NOT NULL,
  `name_singular` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_plural` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flarum_groups`
--

INSERT INTO `flarum_groups` (`id`, `name_singular`, `name_plural`, `color`, `icon`, `is_hidden`) VALUES
(1, 'Admin', 'Admins', '#B72A2A', 'fas fa-wrench', 0),
(2, 'Guest', 'Guests', NULL, NULL, 0),
(3, 'Member', 'Members', NULL, NULL, 0),
(4, 'Mod', 'Mods', '#80349E', 'fas fa-bolt', 0);

-- --------------------------------------------------------

--
-- Table structure for table `flarum_group_permission`
--

CREATE TABLE `flarum_group_permission` (
  `group_id` int UNSIGNED NOT NULL,
  `permission` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flarum_group_permission`
--

INSERT INTO `flarum_group_permission` (`group_id`, `permission`) VALUES
(2, 'viewDiscussions'),
(3, 'discussion.flagPosts'),
(3, 'discussion.likePosts'),
(3, 'discussion.reactPosts'),
(3, 'discussion.reply'),
(3, 'discussion.replyWithoutApproval'),
(3, 'discussion.selectBestAnswerOwnDiscussion'),
(3, 'discussion.startWithoutApproval'),
(3, 'startDiscussion'),
(3, 'viewUserList'),
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
(4, 'user.bypassDecontaminator'),
(4, 'user.createModeratorNotes'),
(4, 'user.suspend'),
(4, 'user.viewLastSeenAt'),
(4, 'user.viewModeratorNotes');

-- --------------------------------------------------------

--
-- Table structure for table `flarum_group_user`
--

CREATE TABLE `flarum_group_user` (
  `user_id` int UNSIGNED NOT NULL,
  `group_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flarum_group_user`
--

INSERT INTO `flarum_group_user` (`user_id`, `group_id`) VALUES
(1, 1),
(2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `flarum_ignored_user`
--

CREATE TABLE `flarum_ignored_user` (
  `user_id` int UNSIGNED NOT NULL,
  `ignored_user_id` int UNSIGNED NOT NULL,
  `ignored_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flarum_links`
--

CREATE TABLE `flarum_links` (
  `id` int UNSIGNED NOT NULL,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` int DEFAULT NULL,
  `is_internal` tinyint(1) NOT NULL DEFAULT '0',
  `is_newtab` tinyint(1) NOT NULL DEFAULT '0',
  `parent_id` int UNSIGNED DEFAULT NULL,
  `icon` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flarum_login_providers`
--

CREATE TABLE `flarum_login_providers` (
  `id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `provider` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `identifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flarum_migrations`
--

CREATE TABLE `flarum_migrations` (
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `extension` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flarum_migrations`
--

INSERT INTO `flarum_migrations` (`migration`, `extension`) VALUES
('2015_02_24_000000_create_access_tokens_table', NULL),
('2015_02_24_000000_create_api_keys_table', NULL),
('2015_02_24_000000_create_config_table', NULL),
('2015_02_24_000000_create_discussions_table', NULL),
('2015_02_24_000000_create_email_tokens_table', NULL),
('2015_02_24_000000_create_groups_table', NULL),
('2015_02_24_000000_create_notifications_table', NULL),
('2015_02_24_000000_create_password_tokens_table', NULL),
('2015_02_24_000000_create_permissions_table', NULL),
('2015_02_24_000000_create_posts_table', NULL),
('2015_02_24_000000_create_users_discussions_table', NULL),
('2015_02_24_000000_create_users_groups_table', NULL),
('2015_02_24_000000_create_users_table', NULL),
('2015_09_15_000000_create_auth_tokens_table', NULL),
('2015_09_20_224327_add_hide_to_discussions', NULL),
('2015_09_22_030432_rename_notification_read_time', NULL),
('2015_10_07_130531_rename_config_to_settings', NULL),
('2015_10_24_194000_add_ip_address_to_posts', NULL),
('2015_12_05_042721_change_access_tokens_columns', NULL),
('2015_12_17_194247_change_settings_value_column_to_text', NULL),
('2016_02_04_095452_add_slug_to_discussions', NULL),
('2017_04_07_114138_add_is_private_to_discussions', NULL),
('2017_04_07_114138_add_is_private_to_posts', NULL),
('2018_01_11_093900_change_access_tokens_columns', NULL),
('2018_01_11_094000_change_access_tokens_add_foreign_keys', NULL),
('2018_01_11_095000_change_api_keys_columns', NULL),
('2018_01_11_101800_rename_auth_tokens_to_registration_tokens', NULL),
('2018_01_11_102000_change_registration_tokens_rename_id_to_token', NULL),
('2018_01_11_102100_change_registration_tokens_created_at_to_datetime', NULL),
('2018_01_11_120604_change_posts_table_to_innodb', NULL),
('2018_01_11_155200_change_discussions_rename_columns', NULL),
('2018_01_11_155300_change_discussions_add_foreign_keys', NULL),
('2018_01_15_071700_rename_users_discussions_to_discussion_user', NULL),
('2018_01_15_071800_change_discussion_user_rename_columns', NULL),
('2018_01_15_071900_change_discussion_user_add_foreign_keys', NULL),
('2018_01_15_072600_change_email_tokens_rename_id_to_token', NULL),
('2018_01_15_072700_change_email_tokens_add_foreign_keys', NULL),
('2018_01_15_072800_change_email_tokens_created_at_to_datetime', NULL),
('2018_01_18_130400_rename_permissions_to_group_permission', NULL),
('2018_01_18_130500_change_group_permission_add_foreign_keys', NULL),
('2018_01_18_130600_rename_users_groups_to_group_user', NULL),
('2018_01_18_130700_change_group_user_add_foreign_keys', NULL),
('2018_01_18_133000_change_notifications_columns', NULL),
('2018_01_18_133100_change_notifications_add_foreign_keys', NULL),
('2018_01_18_134400_change_password_tokens_rename_id_to_token', NULL),
('2018_01_18_134500_change_password_tokens_add_foreign_keys', NULL),
('2018_01_18_134600_change_password_tokens_created_at_to_datetime', NULL),
('2018_01_18_135000_change_posts_rename_columns', NULL),
('2018_01_18_135100_change_posts_add_foreign_keys', NULL),
('2018_01_30_112238_add_fulltext_index_to_discussions_title', NULL),
('2018_01_30_220100_create_post_user_table', NULL),
('2018_01_30_222900_change_users_rename_columns', NULL),
('2018_07_21_000000_seed_default_groups', NULL),
('2018_07_21_000100_seed_default_group_permissions', NULL),
('2018_09_15_041340_add_users_indicies', NULL),
('2018_09_15_041828_add_discussions_indicies', NULL),
('2018_09_15_043337_add_notifications_indices', NULL),
('2018_09_15_043621_add_posts_indices', NULL),
('2018_09_22_004100_change_registration_tokens_columns', NULL),
('2018_09_22_004200_create_login_providers_table', NULL),
('2018_10_08_144700_add_shim_prefix_to_group_icons', NULL),
('2019_06_24_145100_change_posts_content_column_to_mediumtext', NULL),
('2019_10_12_195349_change_posts_add_discussion_foreign_key', NULL),
('2020_03_19_134512_change_discussions_default_comment_count', NULL),
('2020_04_21_130500_change_permission_groups_add_is_hidden', NULL),
('2015_09_21_011527_add_is_approved_to_discussions', 'flarum-approval'),
('2015_09_21_011706_add_is_approved_to_posts', 'flarum-approval'),
('2017_07_22_000000_add_default_permissions', 'flarum-approval'),
('2018_09_29_060444_replace_emoji_shorcuts_with_unicode', 'flarum-emoji'),
('2015_09_02_000000_add_flags_read_time_to_users_table', 'flarum-flags'),
('2015_09_02_000000_create_flags_table', 'flarum-flags'),
('2017_07_22_000000_add_default_permissions', 'flarum-flags'),
('2018_06_27_101500_change_flags_rename_time_to_created_at', 'flarum-flags'),
('2018_06_27_101600_change_flags_add_foreign_keys', 'flarum-flags'),
('2018_06_27_105100_change_users_rename_flags_read_time_to_read_flags_at', 'flarum-flags'),
('2018_09_15_043621_add_flags_indices', 'flarum-flags'),
('2019_10_22_000000_change_reason_text_col_type', 'flarum-flags'),
('2015_05_11_000000_create_posts_likes_table', 'flarum-likes'),
('2015_09_04_000000_add_default_like_permissions', 'flarum-likes'),
('2018_06_27_100600_rename_posts_likes_to_post_likes', 'flarum-likes'),
('2018_06_27_100700_change_post_likes_add_foreign_keys', 'flarum-likes'),
('2015_02_24_000000_add_locked_to_discussions', 'flarum-lock'),
('2017_07_22_000000_add_default_permissions', 'flarum-lock'),
('2018_09_15_043621_add_discussions_indices', 'flarum-lock'),
('2015_05_11_000000_create_mentions_posts_table', 'flarum-mentions'),
('2015_05_11_000000_create_mentions_users_table', 'flarum-mentions'),
('2018_06_27_102000_rename_mentions_posts_to_post_mentions_post', 'flarum-mentions'),
('2018_06_27_102100_rename_mentions_users_to_post_mentions_user', 'flarum-mentions'),
('2018_06_27_102200_change_post_mentions_post_rename_mentions_id_to_mentions_post_id', 'flarum-mentions'),
('2018_06_27_102300_change_post_mentions_post_add_foreign_keys', 'flarum-mentions'),
('2018_06_27_102400_change_post_mentions_user_rename_mentions_id_to_mentions_user_id', 'flarum-mentions'),
('2018_06_27_102500_change_post_mentions_user_add_foreign_keys', 'flarum-mentions'),
('2015_02_24_000000_add_sticky_to_discussions', 'flarum-sticky'),
('2017_07_22_000000_add_default_permissions', 'flarum-sticky'),
('2018_09_15_043621_add_discussions_indices', 'flarum-sticky'),
('2015_05_11_000000_add_subscription_to_users_discussions_table', 'flarum-subscriptions'),
('2015_05_11_000000_add_suspended_until_to_users_table', 'flarum-suspend'),
('2015_09_14_000000_rename_suspended_until_column', 'flarum-suspend'),
('2017_07_22_000000_add_default_permissions', 'flarum-suspend'),
('2018_06_27_111400_change_users_rename_suspend_until_to_suspended_until', 'flarum-suspend'),
('2015_02_24_000000_create_discussions_tags_table', 'flarum-tags'),
('2015_02_24_000000_create_tags_table', 'flarum-tags'),
('2015_02_24_000000_create_users_tags_table', 'flarum-tags'),
('2015_02_24_000000_set_default_settings', 'flarum-tags'),
('2015_10_19_061223_make_slug_unique', 'flarum-tags'),
('2017_07_22_000000_add_default_permissions', 'flarum-tags'),
('2018_06_27_085200_change_tags_columns', 'flarum-tags'),
('2018_06_27_085300_change_tags_add_foreign_keys', 'flarum-tags'),
('2018_06_27_090400_rename_users_tags_to_tag_user', 'flarum-tags'),
('2018_06_27_100100_change_tag_user_rename_read_time_to_marked_as_read_at', 'flarum-tags'),
('2018_06_27_100200_change_tag_user_add_foreign_keys', 'flarum-tags'),
('2018_06_27_103000_rename_discussions_tags_to_discussion_tag', 'flarum-tags'),
('2018_06_27_103100_add_discussion_tag_foreign_keys', 'flarum-tags'),
('2019_04_21_000000_add_icon_to_tags_table', 'flarum-tags'),
('2019_06_29_000000_create_ignored_users_table', 'fof-ignore-users'),
('2020_05_05_000000_migrate_extension_settings', 'fof-impersonate'),
('2016_02_13_000000_create_links_table', 'fof-links'),
('2016_04_19_065618_change_links_columns', 'fof-links'),
('2020_03_16_000000_add_child_links', 'fof-links'),
('2020_02_25_000001_create_moderator_notes_table', 'fof-moderator-notes'),
('2020_02_25_000002_add_default_permissions', 'fof-moderator-notes'),
('2020_02_29_000001_modify_users_notes_foreign_keys', 'fof-moderator-notes'),
('2019_11_04_000001_add_columns_to_discussions_table', 'fof-best-answer'),
('2019_11_04_000002_add_foreign_keys_to_best_anwer_columns', 'fof-best-answer'),
('2019_11_04_000003_migrate_extension_settings', 'fof-best-answer'),
('2020_02_04_205300_add_best_answer_set_timestamp', 'fof-best-answer'),
('2019_07_08_000000_create_reactions_tables', 'fof-reactions'),
('2019_07_08_000001_create_post_reactions_table', 'fof-reactions'),
('2019_07_08_000002_add_default_reaction_permission', 'fof-reactions'),
('2019_07_08_000003_migrate_extension_settings', 'fof-reactions'),
('2019_12_05_000000_add_timestamps_to_post_reactions_table', 'fof-reactions'),
('2019_12_13_120237_add_enabled_column_to_reactions_table', 'fof-reactions'),
('2020_01_19_000000_add_display_column_to_reactions_table', 'fof-reactions'),
('2019_06_07_000000_add_recipients_table', 'fof-byobu'),
('2019_06_07_000001_remove_flagrow_migrations', 'fof-byobu'),
('2019_07_08_000000_add_blocks_pd_to_users', 'fof-byobu'),
('2019_07_09_000000_blocks_pd_index', 'fof-byobu'),
('2020_02_14_214800_fix_user_id_not_nullable_for_group_pds', 'fof-byobu'),
('2020_02_19_110103_remove_retired_settings_key', 'fof-byobu'),
('2019_06_11_000000_add_subscription_to_users_tags_table', 'fof-follow-tags'),
('2019_06_28_000000_add_hide_subscription_option', 'fof-follow-tags'),
('2020_02_06_01_rename_flagrow_permissions', 'fof-upload'),
('2020_02_06_02_rename_flagrow_settings', 'fof-upload'),
('2020_02_06_03_rename_flagrow_tables', 'fof-upload'),
('2020_02_06_04_remove_flagrow_migrations', 'fof-upload'),
('2020_02_06_05_create_files_table', 'fof-upload'),
('2020_02_06_06_create_downloads_table', 'fof-upload'),
('2020_02_06_07_alter_downloads_add_post_constraint', 'fof-upload'),
('2020_04_12_213100__create_profanities_table', 'flarumite-decontaminator'),
('2020_05_10_000000_create_sample_rule', 'flarumite-decontaminator'),
('2020_05_10_000001_rename_profanities_to_decontaminator', 'flarumite-decontaminator'),
('2020_05_10_000002_default_permissions', 'flarumite-decontaminator'),
('2020_07_01_000000_create_bio_column', 'fof-user-bio'),
('2020_09_10_000000_add_icon_to_links_table', 'fof-links'),
('2020_04_31_000000_format_note_content_for_renderer', 'fof-moderator-notes'),
('2020_06_07_000000_set_default', 'fof-sitemap'),
('2020_10_23_000000_users_unified_index_column', 'fof-byobu');

-- --------------------------------------------------------

--
-- Table structure for table `flarum_notifications`
--

CREATE TABLE `flarum_notifications` (
  `id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `from_user_id` int UNSIGNED DEFAULT NULL,
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_id` int UNSIGNED DEFAULT NULL,
  `data` blob,
  `created_at` datetime NOT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `read_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flarum_password_tokens`
--

CREATE TABLE `flarum_password_tokens` (
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flarum_posts`
--

CREATE TABLE `flarum_posts` (
  `id` int UNSIGNED NOT NULL,
  `discussion_id` int UNSIGNED NOT NULL,
  `number` int UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `user_id` int UNSIGNED DEFAULT NULL,
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT ' ',
  `edited_at` datetime DEFAULT NULL,
  `edited_user_id` int UNSIGNED DEFAULT NULL,
  `hidden_at` datetime DEFAULT NULL,
  `hidden_user_id` int UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  `is_approved` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flarum_post_likes`
--

CREATE TABLE `flarum_post_likes` (
  `post_id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flarum_post_mentions_post`
--

CREATE TABLE `flarum_post_mentions_post` (
  `post_id` int UNSIGNED NOT NULL,
  `mentions_post_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flarum_post_mentions_user`
--

CREATE TABLE `flarum_post_mentions_user` (
  `post_id` int UNSIGNED NOT NULL,
  `mentions_user_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flarum_post_reactions`
--

CREATE TABLE `flarum_post_reactions` (
  `id` int UNSIGNED NOT NULL,
  `post_id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `reaction_id` int UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flarum_post_user`
--

CREATE TABLE `flarum_post_user` (
  `post_id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flarum_reactions`
--

CREATE TABLE `flarum_reactions` (
  `id` int UNSIGNED NOT NULL,
  `identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `display` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flarum_reactions`
--

INSERT INTO `flarum_reactions` (`id`, `identifier`, `type`, `enabled`, `display`) VALUES
(1, 'thumbsup', 'emoji', 1, NULL),
(2, 'thumbsdown', 'emoji', 1, NULL),
(3, 'laughing', 'emoji', 1, NULL),
(4, 'confused', 'emoji', 1, NULL),
(5, 'heart', 'emoji', 1, NULL),
(6, 'tada', 'emoji', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `flarum_recipients`
--

CREATE TABLE `flarum_recipients` (
  `id` bigint UNSIGNED NOT NULL,
  `discussion_id` int UNSIGNED DEFAULT NULL,
  `user_id` int UNSIGNED DEFAULT NULL,
  `group_id` int UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `removed_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flarum_registration_tokens`
--

CREATE TABLE `flarum_registration_tokens` (
  `token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `provider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_attributes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flarum_settings`
--

CREATE TABLE `flarum_settings` (
  `key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flarum_settings`
--

INSERT INTO `flarum_settings` (`key`, `value`) VALUES
('allow_post_editing', 'reply'),
('allow_renaming', '10'),
('allow_sign_up', '1'),
('custom_less', ''),
('default_locale', 'en'),
('default_route', '/all'),
('extensions_enabled', '[\"flarum-approval\",\"flarum-bbcode\",\"flarum-emoji\",\"flarum-lang-english\",\"flarum-flags\",\"flarum-lock\",\"flarum-markdown\",\"flarum-mentions\",\"flarum-statistics\",\"flarum-sticky\",\"flarum-subscriptions\",\"flarum-suspend\",\"flarum-tags\",\"fof-formatting\",\"fof-user-bio\",\"fof-ignore-users\",\"bokt-cache-assets\",\"fof-impersonate\",\"fof-links\",\"clarkwinkelmann-circle-groups\",\"fof-merge-discussions\",\"franzl-open-links-in-new-tab\",\"fof-moderator-notes\",\"fof-profile-image-crop\",\"fof-best-answer\",\"fof-reactions\",\"fof-sitemap\",\"fof-byobu\",\"fof-default-user-preferences\",\"fof-follow-tags\",\"fof-split\",\"fof-upload\",\"flarumite-decontaminator\"]'),
('flarum-flags.can_flag_own', '1'),
('flarum-flags.guidelines_url', ''),
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
('forum_description', ''),
('forum_title', 'Flarumite Dev'),
('mail_driver', 'log'),
('mail_from', 'noreply@localhost'),
('theme_colored_header', '0'),
('theme_dark_mode', '0'),
('theme_primary_color', '#4D698E'),
('theme_secondary_color', '#4D698E'),
('version', '0.1.0-beta.15'),
('welcome_message', 'This is beta software and you should not use it in production.'),
('welcome_title', 'Welcome to Flarumite Dev');

-- --------------------------------------------------------

--
-- Table structure for table `flarum_tags`
--

CREATE TABLE `flarum_tags` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `color` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `background_path` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `background_mode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` int DEFAULT NULL,
  `parent_id` int UNSIGNED DEFAULT NULL,
  `default_sort` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_restricted` tinyint(1) NOT NULL DEFAULT '0',
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0',
  `discussion_count` int UNSIGNED NOT NULL DEFAULT '0',
  `last_posted_at` datetime DEFAULT NULL,
  `last_posted_discussion_id` int UNSIGNED DEFAULT NULL,
  `last_posted_user_id` int UNSIGNED DEFAULT NULL,
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flarum_tags`
--

INSERT INTO `flarum_tags` (`id`, `name`, `slug`, `description`, `color`, `background_path`, `background_mode`, `position`, `parent_id`, `default_sort`, `is_restricted`, `is_hidden`, `discussion_count`, `last_posted_at`, `last_posted_discussion_id`, `last_posted_user_id`, `icon`) VALUES
(1, 'General', 'general', '', '#888', NULL, NULL, 0, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, 'fas fa-comments');

-- --------------------------------------------------------

--
-- Table structure for table `flarum_tag_user`
--

CREATE TABLE `flarum_tag_user` (
  `user_id` int UNSIGNED NOT NULL,
  `tag_id` int UNSIGNED NOT NULL,
  `marked_as_read_at` datetime DEFAULT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0',
  `subscription` enum('follow','lurk','ignore','hide') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flarum_users`
--

CREATE TABLE `flarum_users` (
  `id` int UNSIGNED NOT NULL,
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
  `discussion_count` int UNSIGNED NOT NULL DEFAULT '0',
  `comment_count` int UNSIGNED NOT NULL DEFAULT '0',
  `read_flags_at` datetime DEFAULT NULL,
  `suspended_until` datetime DEFAULT NULL,
  `blocks_byobu_pd` tinyint(1) NOT NULL DEFAULT '0',
  `unified_index_with_byobu` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flarum_users`
--

INSERT INTO `flarum_users` (`id`, `username`, `email`, `is_email_confirmed`, `password`, `bio`, `avatar_url`, `preferences`, `joined_at`, `last_seen_at`, `marked_all_as_read_at`, `read_notifications_at`, `discussion_count`, `comment_count`, `read_flags_at`, `suspended_until`, `blocks_byobu_pd`, `unified_index_with_byobu`) VALUES
(1, 'flarumite', 'flarumite@flarumite.com', 1, '$2y$10$KIEe2Wc87aWWlTnvtmeVPOAw1M/FFmFgEetle8BoL7tvw4w0kCDm.', NULL, NULL, NULL, '2020-05-09 22:08:27', '2020-12-21 14:26:50', NULL, NULL, 0, 0, NULL, NULL, 0, 0),
(2, 'moderator', 'moderator@flarumite.com', 1, '$2y$10$oChGVhEf2vIMxTN6iwOA.O6lZqv5SrYTenUZANs81fjzxCpw5WRoW', NULL, NULL, 0x7b22626c6f636b735064223a66616c73652c226e6f746966795f64697363757373696f6e52656e616d65645f616c657274223a747275652c226e6f746966795f64697363757373696f6e4c6f636b65645f616c657274223a747275652c226e6f746966795f706f73744d656e74696f6e65645f616c657274223a747275652c226e6f746966795f706f73744d656e74696f6e65645f656d61696c223a747275652c226e6f746966795f757365724d656e74696f6e65645f616c657274223a747275652c226e6f746966795f757365724d656e74696f6e65645f656d61696c223a747275652c226e6f746966795f6e6577506f73745f616c657274223a747275652c226e6f746966795f6e6577506f73745f656d61696c223a747275652c226e6f746966795f7573657253757370656e6465645f616c657274223a747275652c226e6f746966795f75736572556e73757370656e6465645f616c657274223a747275652c226e6f746966795f73656c65637442657374416e737765725f616c657274223a747275652c226e6f746966795f73656c65637442657374416e737765725f656d61696c223a747275652c226e6f746966795f6177617264656442657374416e737765725f616c657274223a747275652c226e6f746966795f6177617264656442657374416e737765725f656d61696c223a66616c73652c226e6f746966795f62657374416e73776572496e44697363757373696f6e5f616c657274223a66616c73652c226e6f746966795f62657374416e73776572496e44697363757373696f6e5f656d61696c223a66616c73652c226e6f746966795f706f7374526561637465645f616c657274223a747275652c226e6f746966795f62796f62755072697661746544697363757373696f6e437265617465645f616c657274223a747275652c226e6f746966795f62796f62755072697661746544697363757373696f6e437265617465645f656d61696c223a747275652c226e6f746966795f62796f62755072697661746544697363757373696f6e5265706c6965645f616c657274223a747275652c226e6f746966795f62796f62755072697661746544697363757373696f6e5265706c6965645f656d61696c223a747275652c226e6f746966795f62796f6275526563697069656e7452656d6f7665645f616c657274223a747275652c226e6f746966795f62796f6275526563697069656e7452656d6f7665645f656d61696c223a747275652c226e6f746966795f62796f62755072697661746544697363757373696f6e41646465645f616c657274223a747275652c226e6f746966795f62796f62755072697661746544697363757373696f6e41646465645f656d61696c223a747275652c226e6f746966795f6e657744697363757373696f6e496e5461675f616c657274223a747275652c226e6f746966795f6e657744697363757373696f6e496e5461675f656d61696c223a747275652c226e6f746966795f6e6577506f7374496e5461675f616c657274223a747275652c226e6f746966795f6e6577506f7374496e5461675f656d61696c223a747275652c22666f6c6c6f7741667465725265706c79223a747275652c22646973636c6f73654f6e6c696e65223a747275652c22696e64657850726f66696c65223a747275652c226c6f63616c65223a6e756c6c7d, '2020-05-10 15:41:58', '2020-05-10 15:42:57', NULL, NULL, 0, 0, NULL, NULL, 0, 0),
(3, 'user', 'user@flarumite.com', 1, '$2y$10$.Bd1QaM2iVW5qaONc0KQW.bN9V1k98A2aSCE5UKxpi6DUylvXZ9hK', NULL, NULL, 0x7b22626c6f636b735064223a66616c73652c226e6f746966795f64697363757373696f6e52656e616d65645f616c657274223a747275652c226e6f746966795f64697363757373696f6e4c6f636b65645f616c657274223a747275652c226e6f746966795f706f73744d656e74696f6e65645f616c657274223a747275652c226e6f746966795f706f73744d656e74696f6e65645f656d61696c223a747275652c226e6f746966795f757365724d656e74696f6e65645f616c657274223a747275652c226e6f746966795f757365724d656e74696f6e65645f656d61696c223a747275652c226e6f746966795f6e6577506f73745f616c657274223a747275652c226e6f746966795f6e6577506f73745f656d61696c223a747275652c226e6f746966795f7573657253757370656e6465645f616c657274223a747275652c226e6f746966795f75736572556e73757370656e6465645f616c657274223a747275652c226e6f746966795f73656c65637442657374416e737765725f616c657274223a747275652c226e6f746966795f73656c65637442657374416e737765725f656d61696c223a747275652c226e6f746966795f6177617264656442657374416e737765725f616c657274223a747275652c226e6f746966795f6177617264656442657374416e737765725f656d61696c223a66616c73652c226e6f746966795f62657374416e73776572496e44697363757373696f6e5f616c657274223a66616c73652c226e6f746966795f62657374416e73776572496e44697363757373696f6e5f656d61696c223a66616c73652c226e6f746966795f706f7374526561637465645f616c657274223a747275652c226e6f746966795f62796f62755072697661746544697363757373696f6e437265617465645f616c657274223a747275652c226e6f746966795f62796f62755072697661746544697363757373696f6e437265617465645f656d61696c223a747275652c226e6f746966795f62796f62755072697661746544697363757373696f6e5265706c6965645f616c657274223a747275652c226e6f746966795f62796f62755072697661746544697363757373696f6e5265706c6965645f656d61696c223a747275652c226e6f746966795f62796f6275526563697069656e7452656d6f7665645f616c657274223a747275652c226e6f746966795f62796f6275526563697069656e7452656d6f7665645f656d61696c223a747275652c226e6f746966795f62796f62755072697661746544697363757373696f6e41646465645f616c657274223a747275652c226e6f746966795f62796f62755072697661746544697363757373696f6e41646465645f656d61696c223a747275652c226e6f746966795f6e657744697363757373696f6e496e5461675f616c657274223a747275652c226e6f746966795f6e657744697363757373696f6e496e5461675f656d61696c223a747275652c226e6f746966795f6e6577506f7374496e5461675f616c657274223a747275652c226e6f746966795f6e6577506f7374496e5461675f656d61696c223a747275652c22666f6c6c6f7741667465725265706c79223a747275652c22646973636c6f73654f6e6c696e65223a747275652c22696e64657850726f66696c65223a747275652c226c6f63616c65223a6e756c6c7d, '2020-05-10 15:44:12', '2020-05-10 15:44:29', NULL, NULL, 0, 0, NULL, NULL, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `flarum_users_notes`
--

CREATE TABLE `flarum_users_notes` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `note` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `added_by_user_id` int UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `flarum_access_tokens`
--
ALTER TABLE `flarum_access_tokens`
  ADD PRIMARY KEY (`token`),
  ADD KEY `flarum_access_tokens_user_id_foreign` (`user_id`);

--
-- Indexes for table `flarum_api_keys`
--
ALTER TABLE `flarum_api_keys`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `flarum_api_keys_key_unique` (`key`),
  ADD KEY `flarum_api_keys_user_id_foreign` (`user_id`);

--
-- Indexes for table `flarum_decontaminator`
--
ALTER TABLE `flarum_decontaminator`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `flarum_discussions`
--
ALTER TABLE `flarum_discussions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `flarum_discussions_hidden_user_id_foreign` (`hidden_user_id`),
  ADD KEY `flarum_discussions_first_post_id_foreign` (`first_post_id`),
  ADD KEY `flarum_discussions_last_post_id_foreign` (`last_post_id`),
  ADD KEY `flarum_discussions_last_posted_at_index` (`last_posted_at`),
  ADD KEY `flarum_discussions_last_posted_user_id_index` (`last_posted_user_id`),
  ADD KEY `flarum_discussions_created_at_index` (`created_at`),
  ADD KEY `flarum_discussions_user_id_index` (`user_id`),
  ADD KEY `flarum_discussions_comment_count_index` (`comment_count`),
  ADD KEY `flarum_discussions_participant_count_index` (`participant_count`),
  ADD KEY `flarum_discussions_hidden_at_index` (`hidden_at`),
  ADD KEY `flarum_discussions_is_locked_index` (`is_locked`),
  ADD KEY `flarum_discussions_is_sticky_created_at_index` (`is_sticky`,`created_at`),
  ADD KEY `flarum_discussions_best_answer_post_id_foreign` (`best_answer_post_id`),
  ADD KEY `flarum_discussions_best_answer_user_id_foreign` (`best_answer_user_id`),
  ADD KEY `flarum_discussions_best_answer_set_at_index` (`best_answer_set_at`);
ALTER TABLE `flarum_discussions` ADD FULLTEXT KEY `title` (`title`);

--
-- Indexes for table `flarum_discussion_tag`
--
ALTER TABLE `flarum_discussion_tag`
  ADD PRIMARY KEY (`discussion_id`,`tag_id`),
  ADD KEY `flarum_discussion_tag_tag_id_foreign` (`tag_id`);

--
-- Indexes for table `flarum_discussion_user`
--
ALTER TABLE `flarum_discussion_user`
  ADD PRIMARY KEY (`user_id`,`discussion_id`),
  ADD KEY `flarum_discussion_user_discussion_id_foreign` (`discussion_id`);

--
-- Indexes for table `flarum_email_tokens`
--
ALTER TABLE `flarum_email_tokens`
  ADD PRIMARY KEY (`token`),
  ADD KEY `flarum_email_tokens_user_id_foreign` (`user_id`);

--
-- Indexes for table `flarum_flags`
--
ALTER TABLE `flarum_flags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `flarum_flags_post_id_foreign` (`post_id`),
  ADD KEY `flarum_flags_user_id_foreign` (`user_id`),
  ADD KEY `flarum_flags_created_at_index` (`created_at`);

--
-- Indexes for table `flarum_fof_upload_downloads`
--
ALTER TABLE `flarum_fof_upload_downloads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `flarum_fof_upload_downloads_file_id_foreign` (`file_id`),
  ADD KEY `flarum_fof_upload_downloads_discussion_id_foreign` (`discussion_id`),
  ADD KEY `flarum_fof_upload_downloads_actor_id_foreign` (`actor_id`),
  ADD KEY `flarum_fof_upload_downloads_post_id_foreign` (`post_id`);

--
-- Indexes for table `flarum_fof_upload_files`
--
ALTER TABLE `flarum_fof_upload_files`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `flarum_groups`
--
ALTER TABLE `flarum_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `flarum_group_permission`
--
ALTER TABLE `flarum_group_permission`
  ADD PRIMARY KEY (`group_id`,`permission`);

--
-- Indexes for table `flarum_group_user`
--
ALTER TABLE `flarum_group_user`
  ADD PRIMARY KEY (`user_id`,`group_id`),
  ADD KEY `flarum_group_user_group_id_foreign` (`group_id`);

--
-- Indexes for table `flarum_ignored_user`
--
ALTER TABLE `flarum_ignored_user`
  ADD PRIMARY KEY (`user_id`,`ignored_user_id`),
  ADD KEY `flarum_ignored_user_ignored_user_id_foreign` (`ignored_user_id`);

--
-- Indexes for table `flarum_links`
--
ALTER TABLE `flarum_links`
  ADD PRIMARY KEY (`id`),
  ADD KEY `flarum_links_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `flarum_login_providers`
--
ALTER TABLE `flarum_login_providers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `flarum_login_providers_provider_identifier_unique` (`provider`,`identifier`),
  ADD KEY `flarum_login_providers_user_id_foreign` (`user_id`);

--
-- Indexes for table `flarum_notifications`
--
ALTER TABLE `flarum_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `flarum_notifications_from_user_id_foreign` (`from_user_id`),
  ADD KEY `flarum_notifications_user_id_index` (`user_id`);

--
-- Indexes for table `flarum_password_tokens`
--
ALTER TABLE `flarum_password_tokens`
  ADD PRIMARY KEY (`token`),
  ADD KEY `flarum_password_tokens_user_id_foreign` (`user_id`);

--
-- Indexes for table `flarum_posts`
--
ALTER TABLE `flarum_posts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `flarum_posts_discussion_id_number_unique` (`discussion_id`,`number`),
  ADD KEY `flarum_posts_edited_user_id_foreign` (`edited_user_id`),
  ADD KEY `flarum_posts_hidden_user_id_foreign` (`hidden_user_id`),
  ADD KEY `flarum_posts_discussion_id_number_index` (`discussion_id`,`number`),
  ADD KEY `flarum_posts_discussion_id_created_at_index` (`discussion_id`,`created_at`),
  ADD KEY `flarum_posts_user_id_created_at_index` (`user_id`,`created_at`);
ALTER TABLE `flarum_posts` ADD FULLTEXT KEY `content` (`content`);

--
-- Indexes for table `flarum_post_likes`
--
ALTER TABLE `flarum_post_likes`
  ADD PRIMARY KEY (`post_id`,`user_id`),
  ADD KEY `flarum_post_likes_user_id_foreign` (`user_id`);

--
-- Indexes for table `flarum_post_mentions_post`
--
ALTER TABLE `flarum_post_mentions_post`
  ADD PRIMARY KEY (`post_id`,`mentions_post_id`),
  ADD KEY `flarum_post_mentions_post_mentions_post_id_foreign` (`mentions_post_id`);

--
-- Indexes for table `flarum_post_mentions_user`
--
ALTER TABLE `flarum_post_mentions_user`
  ADD PRIMARY KEY (`post_id`,`mentions_user_id`),
  ADD KEY `flarum_post_mentions_user_mentions_user_id_foreign` (`mentions_user_id`);

--
-- Indexes for table `flarum_post_reactions`
--
ALTER TABLE `flarum_post_reactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `flarum_post_reactions_post_id_foreign` (`post_id`),
  ADD KEY `flarum_post_reactions_user_id_foreign` (`user_id`),
  ADD KEY `flarum_post_reactions_reaction_id_foreign` (`reaction_id`);

--
-- Indexes for table `flarum_post_user`
--
ALTER TABLE `flarum_post_user`
  ADD PRIMARY KEY (`post_id`,`user_id`),
  ADD KEY `flarum_post_user_user_id_foreign` (`user_id`);

--
-- Indexes for table `flarum_reactions`
--
ALTER TABLE `flarum_reactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `flarum_recipients`
--
ALTER TABLE `flarum_recipients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `flarum_recipients_discussion_id_foreign` (`discussion_id`),
  ADD KEY `flarum_recipients_user_id_foreign` (`user_id`),
  ADD KEY `flarum_recipients_group_id_foreign` (`group_id`);

--
-- Indexes for table `flarum_registration_tokens`
--
ALTER TABLE `flarum_registration_tokens`
  ADD PRIMARY KEY (`token`);

--
-- Indexes for table `flarum_settings`
--
ALTER TABLE `flarum_settings`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `flarum_tags`
--
ALTER TABLE `flarum_tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `flarum_tags_slug_unique` (`slug`),
  ADD KEY `flarum_tags_parent_id_foreign` (`parent_id`),
  ADD KEY `flarum_tags_last_posted_user_id_foreign` (`last_posted_user_id`),
  ADD KEY `flarum_tags_last_posted_discussion_id_foreign` (`last_posted_discussion_id`);

--
-- Indexes for table `flarum_tag_user`
--
ALTER TABLE `flarum_tag_user`
  ADD PRIMARY KEY (`user_id`,`tag_id`),
  ADD KEY `flarum_tag_user_tag_id_foreign` (`tag_id`);

--
-- Indexes for table `flarum_users`
--
ALTER TABLE `flarum_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `flarum_users_username_unique` (`username`),
  ADD UNIQUE KEY `flarum_users_email_unique` (`email`),
  ADD KEY `flarum_users_joined_at_index` (`joined_at`),
  ADD KEY `flarum_users_last_seen_at_index` (`last_seen_at`),
  ADD KEY `flarum_users_discussion_count_index` (`discussion_count`),
  ADD KEY `flarum_users_comment_count_index` (`comment_count`),
  ADD KEY `flarum_users_blocks_byobu_pd_index` (`blocks_byobu_pd`);

--
-- Indexes for table `flarum_users_notes`
--
ALTER TABLE `flarum_users_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `flarum_users_notes_added_by_user_id_foreign` (`added_by_user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `flarum_api_keys`
--
ALTER TABLE `flarum_api_keys`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flarum_decontaminator`
--
ALTER TABLE `flarum_decontaminator`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `flarum_discussions`
--
ALTER TABLE `flarum_discussions`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flarum_flags`
--
ALTER TABLE `flarum_flags`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flarum_fof_upload_downloads`
--
ALTER TABLE `flarum_fof_upload_downloads`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flarum_fof_upload_files`
--
ALTER TABLE `flarum_fof_upload_files`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flarum_groups`
--
ALTER TABLE `flarum_groups`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `flarum_links`
--
ALTER TABLE `flarum_links`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flarum_login_providers`
--
ALTER TABLE `flarum_login_providers`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flarum_notifications`
--
ALTER TABLE `flarum_notifications`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flarum_posts`
--
ALTER TABLE `flarum_posts`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flarum_post_reactions`
--
ALTER TABLE `flarum_post_reactions`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flarum_reactions`
--
ALTER TABLE `flarum_reactions`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `flarum_recipients`
--
ALTER TABLE `flarum_recipients`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flarum_tags`
--
ALTER TABLE `flarum_tags`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `flarum_users`
--
ALTER TABLE `flarum_users`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `flarum_users_notes`
--
ALTER TABLE `flarum_users_notes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `flarum_access_tokens`
--
ALTER TABLE `flarum_access_tokens`
  ADD CONSTRAINT `flarum_access_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `flarum_api_keys`
--
ALTER TABLE `flarum_api_keys`
  ADD CONSTRAINT `flarum_api_keys_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `flarum_discussions`
--
ALTER TABLE `flarum_discussions`
  ADD CONSTRAINT `flarum_discussions_best_answer_post_id_foreign` FOREIGN KEY (`best_answer_post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `flarum_discussions_best_answer_user_id_foreign` FOREIGN KEY (`best_answer_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `flarum_discussions_first_post_id_foreign` FOREIGN KEY (`first_post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `flarum_discussions_hidden_user_id_foreign` FOREIGN KEY (`hidden_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `flarum_discussions_last_post_id_foreign` FOREIGN KEY (`last_post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `flarum_discussions_last_posted_user_id_foreign` FOREIGN KEY (`last_posted_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `flarum_discussions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `flarum_discussion_tag`
--
ALTER TABLE `flarum_discussion_tag`
  ADD CONSTRAINT `flarum_discussion_tag_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `flarum_discussions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `flarum_discussion_tag_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `flarum_tags` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `flarum_discussion_user`
--
ALTER TABLE `flarum_discussion_user`
  ADD CONSTRAINT `flarum_discussion_user_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `flarum_discussions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `flarum_discussion_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `flarum_email_tokens`
--
ALTER TABLE `flarum_email_tokens`
  ADD CONSTRAINT `flarum_email_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `flarum_flags`
--
ALTER TABLE `flarum_flags`
  ADD CONSTRAINT `flarum_flags_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `flarum_flags_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `flarum_fof_upload_downloads`
--
ALTER TABLE `flarum_fof_upload_downloads`
  ADD CONSTRAINT `flarum_fof_upload_downloads_actor_id_foreign` FOREIGN KEY (`actor_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `flarum_fof_upload_downloads_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `flarum_discussions` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `flarum_fof_upload_downloads_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `flarum_fof_upload_files` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `flarum_fof_upload_downloads_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `flarum_group_permission`
--
ALTER TABLE `flarum_group_permission`
  ADD CONSTRAINT `flarum_group_permission_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `flarum_groups` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `flarum_group_user`
--
ALTER TABLE `flarum_group_user`
  ADD CONSTRAINT `flarum_group_user_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `flarum_groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `flarum_group_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `flarum_ignored_user`
--
ALTER TABLE `flarum_ignored_user`
  ADD CONSTRAINT `flarum_ignored_user_ignored_user_id_foreign` FOREIGN KEY (`ignored_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `flarum_ignored_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `flarum_links`
--
ALTER TABLE `flarum_links`
  ADD CONSTRAINT `flarum_links_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `flarum_links` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `flarum_login_providers`
--
ALTER TABLE `flarum_login_providers`
  ADD CONSTRAINT `flarum_login_providers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `flarum_notifications`
--
ALTER TABLE `flarum_notifications`
  ADD CONSTRAINT `flarum_notifications_from_user_id_foreign` FOREIGN KEY (`from_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `flarum_notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `flarum_password_tokens`
--
ALTER TABLE `flarum_password_tokens`
  ADD CONSTRAINT `flarum_password_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `flarum_posts`
--
ALTER TABLE `flarum_posts`
  ADD CONSTRAINT `flarum_posts_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `flarum_discussions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `flarum_posts_edited_user_id_foreign` FOREIGN KEY (`edited_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `flarum_posts_hidden_user_id_foreign` FOREIGN KEY (`hidden_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `flarum_posts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `flarum_post_likes`
--
ALTER TABLE `flarum_post_likes`
  ADD CONSTRAINT `flarum_post_likes_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `flarum_post_likes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `flarum_post_mentions_post`
--
ALTER TABLE `flarum_post_mentions_post`
  ADD CONSTRAINT `flarum_post_mentions_post_mentions_post_id_foreign` FOREIGN KEY (`mentions_post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `flarum_post_mentions_post_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `flarum_post_mentions_user`
--
ALTER TABLE `flarum_post_mentions_user`
  ADD CONSTRAINT `flarum_post_mentions_user_mentions_user_id_foreign` FOREIGN KEY (`mentions_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `flarum_post_mentions_user_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `flarum_post_reactions`
--
ALTER TABLE `flarum_post_reactions`
  ADD CONSTRAINT `flarum_post_reactions_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `flarum_post_reactions_reaction_id_foreign` FOREIGN KEY (`reaction_id`) REFERENCES `flarum_reactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `flarum_post_reactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `flarum_post_user`
--
ALTER TABLE `flarum_post_user`
  ADD CONSTRAINT `flarum_post_user_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `flarum_posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `flarum_post_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `flarum_recipients`
--
ALTER TABLE `flarum_recipients`
  ADD CONSTRAINT `flarum_recipients_discussion_id_foreign` FOREIGN KEY (`discussion_id`) REFERENCES `flarum_discussions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `flarum_recipients_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `flarum_groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `flarum_recipients_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `flarum_tags`
--
ALTER TABLE `flarum_tags`
  ADD CONSTRAINT `flarum_tags_last_posted_discussion_id_foreign` FOREIGN KEY (`last_posted_discussion_id`) REFERENCES `flarum_discussions` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `flarum_tags_last_posted_user_id_foreign` FOREIGN KEY (`last_posted_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `flarum_tags_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `flarum_tags` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `flarum_tag_user`
--
ALTER TABLE `flarum_tag_user`
  ADD CONSTRAINT `flarum_tag_user_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `flarum_tags` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `flarum_tag_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `flarum_users_notes`
--
ALTER TABLE `flarum_users_notes`
  ADD CONSTRAINT `flarum_users_notes_added_by_user_id_foreign` FOREIGN KEY (`added_by_user_id`) REFERENCES `flarum_users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `flarum_users_notes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `flarum_users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
