package com.example.acmemarket_client.history;

import android.view.View;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.acmemarket_client.R;

public class HistoryItemViewHolder extends RecyclerView.ViewHolder {

    public TextView historyItemList, historyBalance, historyTotal;

    public HistoryItemViewHolder(@NonNull View itemView) {
        super(itemView);
        historyItemList = itemView.findViewById(R.id.historyItemList);
        historyBalance = itemView.findViewById(R.id.historyValueBalance);
        historyTotal = itemView.findViewById(R.id.historyValueTotal);
    }
}
