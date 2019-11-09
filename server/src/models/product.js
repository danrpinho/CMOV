'use strict';
module.exports = (sequelize, DataTypes) => {
    const Product = sequelize.define('Product', {
        price: {
            type: DataTypes.FLOAT.UNSIGNED,
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
            as: 'productItems',
            onDelete: 'CASCADE',
        });
    };

    return Product;
};