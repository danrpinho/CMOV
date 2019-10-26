'use strict';
module.exports = (sequelize, DataTypes) => {
    const ShoppingList = sequelize.define('ShoppingList', {
        totalcost: {
            type: DataTypes.INTEGER,
            allowNull: false,
        }
    });

    ShoppingList.associate = (models) => {
        ShoppingList.hasMany(models.Product, {
            foreignKey: 'productId',
            as: 'productItems',
        });
        ShoppingList.belongsTo(models.User, {
            foreignKey: 'userId',
            onDelete: 'CASCADE',
        });
    };

    return ShoppingList;
};