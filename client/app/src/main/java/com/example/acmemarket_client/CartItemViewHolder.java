package com.example.acmemarket_client;

import android.view.View;
import android.widget.ImageButton;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

public class CartItemViewHolder extends RecyclerView.ViewHolder {

    private TextView itemName;
    private ImageButton deleteButton;

    public CartItemViewHolder(@NonNull View itemView) {
        super(itemView);
        itemName = (TextView) itemView.findViewById(R.id.cart_item_name);
        deleteButton = (ImageButton) itemView.findViewById(R.id.cart_item_delete);
    }
}
