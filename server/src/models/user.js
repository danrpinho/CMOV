'use strict';

const bcrypt = require('bcrypt');
const SALT_WORK_FACTOR = 10;

module.exports = (sequelize, DataTypes) => {
    const User = sequelize.define('User', {
            email: {
                type: DataTypes.STRING,
                allowNull: false,
                unique: true,
            },
            name: {
                type: DataTypes.STRING,
                allowNull: false,
            },
            uuid: {
                type: DataTypes.STRING,
                allowNull: false,
                unique: true,
            },
            balance: {
                type: DataTypes.INTEGER,
                allowNull: false,
                defaultValue: 0
            },
            publickey: {
                type: DataTypes.STRING,
                unique: true,
                allowNull: false,
            },
            password: {
                type: DataTypes.STRING,
                allowNull: false,
            },            
            username: {
                type: DataTypes.STRING,
                unique: true,
                allowNull: false,
            },
            totalspent:{
                type: DataTypes.INTEGER,
                allowNull: false,
                defaultValue: 0
            }
        },
        {});

    User.prototype.isValidPassword = async function (password) {
        const compare = await bcrypt.compare(password, this.password);
        return compare;
    };

    User.associate = function (models) {
        User.hasMany(models.ShoppingList, {
            foreignKey: 'userId',
            as: 'shoppingLists',
        });

        User.hasMany(models.Voucher, {
            foreignKey: 'userId',
            as: 'vouchers',
        });
    };


    User.beforeCreate(async function (user) {
        user.password = await bcrypt.hash(user.password, SALT_WORK_FACTOR);
    });

    return User;
};