package com.example.acmemarket_client.history;

import android.view.LayoutInflater;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.acmemarket_client.R;
import com.example.acmemarket_client.model.Product;
import com.example.acmemarket_client.model.ShoppingList;

import java.util.List;
import java.util.Locale;

public class HistoryItemAdapter extends RecyclerView.Adapter<HistoryItemViewHolder> {
    private List<ShoppingList> transactions;

    public HistoryItemAdapter(List data) {
        this.transactions = data;
    }

    @NonNull
    @Override
    public HistoryItemViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        return new HistoryItemViewHolder(LayoutInflater.from(parent.getContext())
                .inflate(R.layout.recycle_history_item, parent, false));

    }

    @Override
    public void onBindViewHolder(@NonNull HistoryItemViewHolder holder, int position) {
        String itemList = getItemList(transactions.get(position));
        String total = "€ "+ getTotal(transactions.get(position));
        String balanceUsed = "€ " + getBalanceUsed(transactions.get(position));
        holder.historyItemList.setText(String.format(Locale.getDefault(), "%s", itemList));
        holder.historyBalance.setText(String.format(Locale.getDefault(), "%s", balanceUsed));
        holder.historyTotal.setText(String.format(Locale.getDefault(), "%s", total));
    }

    private String getBalanceUsed(ShoppingList shoppingList) {
       return String.format(Locale.getDefault(), "%.2f", shoppingList.getDiscounted());
    }

    private String getTotal(ShoppingList shoppingList) {
        return String.format(Locale.getDefault(), "%.2f", shoppingList.getTotalCost());
    }

    private String getItemList(ShoppingList transaction) {

        StringBuilder res = new StringBuilder();
        for (int i = 0; i < transaction.getProductItems().size(); i++) {
            Product elem = transaction.getProductItems().get(i);
            res.append(elem.getUuid()).append(" (").append(elem.getPrice()).append(")");
            if (i < transaction.getProductItems().size() - 1)
                res.append("\n");
        }
        return res.toString();
    }


    @Override
    public int getItemCount() {
        if (transactions == null)
            return 0;
        else return transactions.size();
    }

    public void setList(List<ShoppingList> list) {
        transactions = list;
        notifyItemRangeChanged(0, transactions.size());
    }
}
