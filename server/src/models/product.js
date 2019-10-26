'use strict';
module.exports = (sequelize, DataTypes) => {
    const Product = sequelize.define('Product', {
        price: {
            type: DataTypes.INTEGER,
            allowNull: false,
        },
        uuid: {
            type: DataTypes.STRING,
            allowNull: false,
            unique:true,
        },
    });

    Product.associate = (models) => {
        Product.belongsTo(models.ShoppingList, {
            foreignKey: 'shoppingListId',
            onDelete: 'CASCADE',
        });
    };

    return Product;
};