/*
  Warnings:

  - You are about to drop the column `professional_Id` on the `business` table. All the data in the column will be lost.
  - Added the required column `owner_Id` to the `business` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `business` DROP FOREIGN KEY `business_professional_Id_fkey`;

-- AlterTable
ALTER TABLE `business` DROP COLUMN `professional_Id`,
    ADD COLUMN `owner_Id` VARCHAR(191) NOT NULL;

-- AddForeignKey
ALTER TABLE `business` ADD CONSTRAINT `business_owner_Id_fkey` FOREIGN KEY (`owner_Id`) REFERENCES `professionals`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
