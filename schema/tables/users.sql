DROP TABLE IF EXISTS `steelfig`.`users` ;

CREATE TABLE IF NOT EXISTS `steelfig`.`users` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `account_id` INT UNSIGNED NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `name` VARCHAR(255) NULL,
  `oauth_token` VARCHAR(100) NULL,
  `api_token` CHAR(40) NULL,
  `avatar` VARCHAR(255) NULL,
  `activated_at` DATETIME NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_accounts_users`
    FOREIGN KEY (`account_id`)
    REFERENCES `steelfig`.`accounts` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  UNIQUE INDEX `api_token_UNIQUE` (`api_token` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;
