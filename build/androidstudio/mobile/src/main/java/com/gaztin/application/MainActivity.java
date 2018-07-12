package com.gaztin.application;

import android.app.NativeActivity;
import android.os.Bundle;

public class MainActivity extends NativeActivity
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
}
