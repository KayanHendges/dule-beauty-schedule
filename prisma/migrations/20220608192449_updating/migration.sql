/*
  Warnings:

  - You are about to drop the `customers_services` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `orders_customers_services` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `users` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `users_professionals` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[email]` on the table `professionals` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `password` to the `professionals` table without a default value. This is not possible if the table is not empty.
  - Made the column `email` on table `professionals` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE `customers_services` DROP FOREIGN KEY `customers_services_customer_id_fkey`;

-- DropForeignKey
ALTER TABLE `customers_services` DROP FOREIGN KEY `customers_services_service_id_fkey`;

-- DropForeignKey
ALTER TABLE `orders_customers_services` DROP FOREIGN KEY `orders_customers_services_customer_service_id_fkey`;

-- DropForeignKey
ALTER TABLE `orders_customers_services` DROP FOREIGN KEY `orders_customers_services_order_id_fkey`;

-- DropForeignKey
ALTER TABLE `orders_customers_services` DROP FOREIGN KEY `orders_customers_services_provider_service_package_id_fkey`;

-- DropForeignKey
ALTER TABLE `users_professionals` DROP FOREIGN KEY `users_professionals_professional_id_fkey`;

-- DropForeignKey
ALTER TABLE `users_professionals` DROP FOREIGN KEY `users_professionals_user_id_fkey`;

-- DropIndex
DROP INDEX `professionals_name_key` ON `professionals`;

-- AlterTable
ALTER TABLE `professionals` ADD COLUMN `password` VARCHAR(191) NOT NULL,
    MODIFY `email` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `services` ADD COLUMN `business_id` VARCHAR(191) NULL;

-- DropTable
DROP TABLE `customers_services`;

-- DropTable
DROP TABLE `orders_customers_services`;

-- DropTable
DROP TABLE `users`;

-- DropTable
DROP TABLE `users_professionals`;

-- CreateTable
CREATE TABLE `business` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `owner_Id` VARCHAR(191) NOT NULL,
    `modified` DATETIME(3) NOT NULL,
    `created` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `business_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `business_professionals` (
    `id` VARCHAR(191) NOT NULL,
    `business_id` VARCHAR(191) NOT NULL,
    `professional_id` VARCHAR(191) NOT NULL,
    `modified` DATETIME(3) NOT NULL,
    `created` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `services_customers` (
    `id` VARCHAR(191) NOT NULL,
    `customer_id` VARCHAR(191) NOT NULL,
    `order_id` VARCHAR(191) NOT NULL,
    `service_id` VARCHAR(191) NOT NULL,
    `modified` DATETIME(3) NOT NULL,
    `created` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `professionals_email_key` ON `professionals`(`email`);

-- AddForeignKey
ALTER TABLE `business` ADD CONSTRAINT `business_owner_Id_fkey` FOREIGN KEY (`owner_Id`) REFERENCES `professionals`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `business_professionals` ADD CONSTRAINT `business_professionals_business_id_fkey` FOREIGN KEY (`business_id`) REFERENCES `business`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `business_professionals` ADD CONSTRAINT `business_professionals_professional_id_fkey` FOREIGN KEY (`professional_id`) REFERENCES `professionals`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `services` ADD CONSTRAINT `services_business_id_fkey` FOREIGN KEY (`business_id`) REFERENCES `business`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `services_customers` ADD CONSTRAINT `services_customers_service_id_fkey` FOREIGN KEY (`service_id`) REFERENCES `services`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `services_customers` ADD CONSTRAINT `services_customers_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `services_customers` ADD CONSTRAINT `services_customers_order_id_fkey` FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
