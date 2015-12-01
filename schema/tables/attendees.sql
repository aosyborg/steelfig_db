DROP TABLE IF EXISTS `steelfig`.`attendees` ;

CREATE TABLE IF NOT EXISTS `steelfig`.`attendees` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `event_id` INT UNSIGNED NOT NULL,
  `account_id` INT UNSIGNED NOT NULL,
  `buying_for` INT UNSIGNED NULL,
  `status` TINYINT UNSIGNED NOT NULL DEFAULT 0, -- 0 pending 1 maybe 2 declined 3 attending
  `comment` VARCHAR(255) NULL,
  `notify_on_event_update` TINYINT(1) NOT NULL DEFAULT 1,
  `notify_on_list_update` TINYINT(1) NOT NULL DEFAULT 0,
  `notify_on_recipient_list_update` TINYINT(1) NOT NULL DEFAULT 0,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_attendees_events_idx` (`event_id` ASC),
  INDEX `fk_attendees_accounts_idx` (`account_id` ASC),
  UNIQUE INDEX `event_account_UNIQUE` (`event_id` ASC, `account_id` ASC),
  INDEX `fk_attendees_attendees_idx` (`buying_for` ASC),
  CONSTRAINT `fk_attendees_events`
    FOREIGN KEY (`event_id`)
    REFERENCES `steelfig`.`events` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_attendees_accounts`
    FOREIGN KEY (`account_id`)
    REFERENCES `steelfig`.`accounts` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_attendees_attendees`
    FOREIGN KEY (`buying_for`)
    REFERENCES `steelfig`.`attendees` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
