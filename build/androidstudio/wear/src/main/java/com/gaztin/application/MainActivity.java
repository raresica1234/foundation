package com.gaztin.application;

import android.os.Bundle;
import android.support.wearable.activity.WearableActivity;

public class MainActivity extends WearableActivity
{
	static
	{
		System.loadLibrary("project");
	}

	@Override
	protected void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
	}

	@Override
	protected void onResume()
	{
		super.onResume();
	}

	@Override
	protected void onPause()
	{
		super.onPause();
	}
}
