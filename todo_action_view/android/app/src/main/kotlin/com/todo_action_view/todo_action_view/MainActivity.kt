package com.todo_action_view.todo_action_view

import android.content.Context;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import android.content.Intent;
import io.flutter.plugin.common.MethodChannel;
import android.database.Cursor;
import android.net.Uri;
import android.provider.MediaStore;
import android.util.Log;
import java.io.File;

class MainActivity: FlutterActivity() {
  
  private val CHANNEL = "app.channel.shared.document"
  private val METHOD_CHANNEL="getSharedDocument";
  private var sharedDocumentPath: String? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
      val intent = getIntent();
      val action = intent.action
      val type = intent.type
  
      if (Intent.ACTION_SEND.equals(action) && type != null) {
        val value = intent.clipData?.getItemAt(0)?.getUri()
        
        Log.d("MY_ACTION_SEND_DOCUMENT", value.toString());
        if (value != null) {
        
         sharedDocumentPath = value.getPathString(context);
       }
  
    }
      if (Intent.ACTION_VIEW.equals(action) && type != null) {
         val value = intent.data
         
         Log.d("MY_ACTION_VIEW_DOCUMENT", intent.toString());
         if (value != null) {
          sharedDocumentPath = value.getPathString(context);
        }
      }
  
      MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
              .setMethodCallHandler { call, result ->
                if (call.method == METHOD_CHANNEL) {
                    result.success(sharedDocumentPath)
                    sharedDocumentPath = null
                  } else {
                    result.notImplemented()
                  }
              }
    }

    fun Uri.getPathString(context: Context): String {
      var path: String = ""
      context.contentResolver.query(
          this, arrayOf(MediaStore.Images.Media.DATA),
          null, null, null
      )?.apply {
          val columnIndex = getColumnIndexOrThrow(MediaStore.Images.Media.DATA)
          moveToFirst()
          path = getString(columnIndex)
          close()
      }
  
      return path
  }   
}