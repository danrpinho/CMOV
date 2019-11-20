'use strict';
module.exports = (sequelize, DataTypes) => {
    const ShoppingList = sequelize.define('ShoppingList', {
        totalCost: {
            type: DataTypes.FLOAT.UNSIGNED,
            allowNull: false,
            defaultValue: 0,
        },
        discounted: {
            type: DataTypes.FLOAT.UNSIGNED,
            allowNull: false,
            defaultValue: 0,
        }
    });

    ShoppingList.associate = (models) => {
        ShoppingList.hasMany(models.Product, {
            foreignKey: 'shoppingListId',
            as: 'productItems',
        });
        ShoppingList.belongsTo(models.User, {
            foreignKey: 'userId',
            onDelete: 'CASCADE',
        });
    };

    return ShoppingList;
};