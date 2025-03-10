package com.example.acmemarket_client.cart;

import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.acmemarket_client.R;

public class CartItemViewHolder extends RecyclerView.ViewHolder {

    public TextView itemName;
    public ImageView deleteButton;

    public CartItemViewHolder(@NonNull View itemView) {
        super(itemView);
        itemName = (TextView) itemView.findViewById(R.id.cart_item_name);
        deleteButton = (ImageView) itemView.findViewById(R.id.cart_item_delete);
    }
}
