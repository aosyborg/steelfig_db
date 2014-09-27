DROP TABLE IF EXISTS `steelfig`.`messages` ;

CREATE TABLE IF NOT EXISTS `steelfig`.`messages` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `event_id` INT UNSIGNED NOT NULL,
  `from_id` INT UNSIGNED NOT NULL,
  `to_id` INT UNSIGNED NOT NULL,
  `subject` VARCHAR(255) NOT NULL,
  `message` TEXT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `read_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_messages_events`
    FOREIGN KEY (`event_id`)
    REFERENCES events (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_messages_accounts1`
    FOREIGN KEY (`from_id`)
    REFERENCES accounts (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_messages_accounts2`
    FOREIGN KEY (`to_id`)
    REFERENCES accounts (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
ENGINE = InnoDB;
