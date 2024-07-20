package com.flutterjunction.homescreen_widget  // your package name

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

import android.os.Bundle
import android.os.Handler
import android.os.Looper

class HomeScreenWidgetProvider : HomeWidgetProvider() {
     override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_layout).apply {

                // Open App on Widget Click
                val pendingIntent = HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java)
                setOnClickPendingIntent(R.id.widget_root, pendingIntent)

                val week = widgetData.getString("week", null)
                val time = widgetData.getString("time", null)
                val date = widgetData.getString("date", null)

//
                setTextViewText(R.id.week,week)
                setTextViewText(R.id.time,time)
                setTextViewText(R.id.date,date)

                // after every minut time is update

//                val mDelay: Long = 500
//                Handler(Looper.getMainLooper()).postDelayed({
//                    HomeWidgetBackgroundIntent.getBroadcast(context, Uri.parse("myAppWidget://updatecounter"))
//                    println("this is my time")
//                                                            }, mDelay)


                

//                 Pending intent to update counter on button click   backgroundCallback
//                val backgroundIntent = HomeWidgetBackgroundIntent.getBroadcast(context, Uri.parse("myAppWidget://updatecounter"))
//                setOnClickPendingIntent(R.id.bt_update, backgroundIntent)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}