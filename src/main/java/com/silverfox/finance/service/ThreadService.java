package com.silverfox.finance.service;

import static com.silverfox.finance.util.ConstantUtil.DEFAULT_THREADS;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadFactory;

public class ThreadService {
	protected static final ExecutorService EXECUTOR_SERVICE = Executors.newFixedThreadPool(DEFAULT_THREADS, new ThreadFactory(){
		@Override
		public Thread newThread(Runnable r) {
			Thread t = new Thread(r);
			t.setDaemon(true);
			return t;
		}
	});
	
	static {
		Runtime.getRuntime().addShutdownHook(new Thread(){
			@Override
			public void run() {
				if (EXECUTOR_SERVICE != null) {
					EXECUTOR_SERVICE.shutdown();
				}
			}
		});
	}
}