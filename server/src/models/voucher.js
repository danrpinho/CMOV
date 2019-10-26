'use strict';
module.exports = (sequelize, DataTypes) => {
    const Voucher = sequelize.define('Voucher', {
        used: {
            type: DataTypes.BOOLEAN,
            defaultValue: false,
        },
    });

    Voucher.associate = (models) => {
        Voucher.belongsTo(models.User, {
            foreignKey: 'userId',
            onDelete: 'CASCADE',
        });
    };

    return Voucher;
};