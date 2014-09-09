DROP TABLE IF EXISTS `steelfig`.`api_requests` ;

CREATE TABLE IF NOT EXISTS `steelfig`.`api_requests` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `api_token_id` INT UNSIGNED NOT NULL,
  `url` VARCHAR(255) NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `api_token_id`),
  INDEX `fk_api_requests_api_tokens_idx` (`api_token_id` ASC),
  CONSTRAINT `fk_api_requests_api_tokens`
    FOREIGN KEY (`api_token_id`)
    REFERENCES `steelfig`.`api_tokens` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
