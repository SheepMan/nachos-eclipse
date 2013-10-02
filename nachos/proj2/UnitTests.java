package nachos.proj2;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

import nachos.test.unittest.TestHarness;

public class UnitTests extends TestHarness {

	@Test
	public void exampleTest1() {
		enqueueJob(new Runnable() {

			@Override
			public void run() {
                System.out.println("Starting Project 2 exampleTest1!");
				// Uncomment to see the unit test fail!
				//assertTrue("Project 2 exampleTest1 failed!", false);
                System.out.println("Finishing Project 2 exampleTest1!");
			}

		});
	}
	
	@Test
	public void exampleTest2() {
		enqueueJob(new Runnable() {

			@Override
			public void run() {
                System.out.println("Starting Project 2 exampleTest2!");
				// Uncomment to see the unit test fail!
				//assertTrue("Project 2 exampleTest2 failed!", false);
                System.out.println("Finishing Project 2 exampleTest2!");
			}

		});
	}

}
