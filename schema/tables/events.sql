DROP TABLE IF EXISTS `steelfig`.`events` ;

CREATE TABLE IF NOT EXISTS `steelfig`.`events` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `account_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `location` VARCHAR(255) NULL,
  `is_active` TINYINT(1) NOT NULL DEFAULT 1,
  `start_at` DATETIME NULL,
  `end_at` DATETIME NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_events_accounts_id` (`account_id` ASC),
  CONSTRAINT `fk_events_accounts`
    FOREIGN KEY (`account_id`)
    REFERENCES `steelfig`.`accounts` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;