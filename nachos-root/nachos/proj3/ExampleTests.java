package nachos.proj3;

import nachos.threads.KThread;

import org.junit.Test;
import static org.junit.Assert.assertTrue;

public class ExampleTests {
	
	@Test
	public void exampleTest1() {
        System.out.println("Starting Project 3 exampleTest1!");
		UnitTests.enqueueJob(new Runnable() {

			@Override
			public void run() {
				KThread.yield();
			}

		});
		// Uncomment to see the unit test fail!
		//assertTrue("Project 3 exampleTest1 failed!", false);		
        System.out.println("Finishing Project 3 exampleTest1!");
	}
	
	@Test
	public void exampleTest2() {
        System.out.println("Starting Project 3 exampleTest2!");
		UnitTests.enqueueJob(new Runnable() {

			@Override
			public void run() {
				KThread.yield();
			}

		});
		// Uncomment to see the unit test fail!
		//assertTrue("Project 3 exampleTest1 failed!", false);		
        System.out.println("Finishing Project 3 exampleTest2!");
	}
}