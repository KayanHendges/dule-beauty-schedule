/*
  Warnings:

  - You are about to drop the column `comission` on the `services` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `services` table. All the data in the column will be lost.
  - Added the required column `client_id` to the `services` table without a default value. This is not possible if the table is not empty.
  - Added the required column `end_service` to the `services` table without a default value. This is not possible if the table is not empty.
  - Added the required column `provider_service_id` to the `services` table without a default value. This is not possible if the table is not empty.
  - Added the required column `start_service` to the `services` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX `services_name_key` ON `services`;

-- AlterTable
ALTER TABLE `services` DROP COLUMN `comission`,
    DROP COLUMN `name`,
    ADD COLUMN `client_id` INTEGER NOT NULL,
    ADD COLUMN `end_service` DATETIME(3) NOT NULL,
    ADD COLUMN `provider_service_id` INTEGER NOT NULL,
    ADD COLUMN `start_service` DATETIME(3) NOT NULL;

-- CreateTable
CREATE TABLE `provider_services` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `comission` DECIMAL(65, 30) NOT NULL,
    `standart_duration` INTEGER NULL,
    `professional_id` INTEGER NOT NULL,

    UNIQUE INDEX `provider_services_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `clients` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `phone_number` INTEGER NULL,
    `instagram` VARCHAR(191) NULL,
    `email` VARCHAR(191) NULL,

    UNIQUE INDEX `clients_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `provider_services` ADD CONSTRAINT `provider_services_professional_id_fkey` FOREIGN KEY (`professional_id`) REFERENCES `professionals`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `services` ADD CONSTRAINT `services_provider_service_id_fkey` FOREIGN KEY (`provider_service_id`) REFERENCES `provider_services`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `services` ADD CONSTRAINT `services_client_id_fkey` FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
