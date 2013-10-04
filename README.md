Overview
===================
This distribution of nachos contains all of the original nachos code, wrapped
in a default eclipse workspace that includes Run Configurations for
running tests with JUnit. Follow the instructions below to get set up and 
running with Nachos and JUnit in eclipse:

##### Required steps:

1. Launch eclipse with your workspace pointing to the directory containing this 
   README (i.e. 'nachos-eclipse' if you haven't chosen to rename it). If you 
   are already running eclipse, you can just switch workspaces

        File- > Switch Workspace
    
2. Refresh your 'nachos-root' tree to force a rebuild of all .class files

        Right click on 'nachos-root' and select Refresh (or press F5)
    
3. Select one of the JUnit Run Configurations that have been set up for each 
   project and run it.  You should see some sample unit tests run to 
   completion and Nachos should exit gracefully.

        Run -> Run Configurations -> JUnit -> Project {1,2,3,4}
        
##### Optional steps:

1. Set up a remote for this repo to point to your CS162 project group repo.
   Doing so will allow you to both track changes from the original 
   'nachos-eclipse' repo as well as push changes to your own copy of the 
   repo as you extend nachos while working on the projects.

        git remote add groupXX git@github.com:Berkeley-CS162/groupXX.git

    From here on out you can pull changes from the original repo with
    
        git pull origin master

    And push/pull changes to your group repo with
    
        git push groupXX master
        git pull groupXX master

2. Run the runme-once.sh script. Since a default workspace is set up for you, 
   we've had to store some of the metadata files associated with the workspace
   as part of the repo itself.  If you want git to ignore updates to this 
   metadata, you can run the runme-once.sh script to force git to ignore 
   updates to these files.

        ./runme-once.sh

Creating Unit Tests
===================
A UnitTests test harness has been set up for each project and is located in the
one of the files listed below:

    nachos.proj1
      UnitTests.java
    
    nachos.proj2
      UnitTests.java
    
    nachos.proj3
      UnitTests.java
    
    nachos.proj4
      UnitTests.java

The UnitTests test harness for each project is set up as a JUnit Test Suite,
which will launch a single instance of Nachos and run any tests you define as
part of the suite one after another.  Different sets of unit tests can be
logically grouped into their own class, and added to the Test Suite as desired.

As an example, consider the definition of the UnitTests test suite for Project
1:

```java
@RunWith(Suite.class)
@SuiteClasses({
    ExampleTests.class,
//  CommunicatorTests.class,
})
public class UnitTests extends TestHarness {}
```

The UnitTests class is defined with an attribute of @SuiteClasses, where any
classes you define to contain Nachos JUnit tests should be listed.  We have
provided both an ExampleTests class, as well as a fully functional
CommunicatorTests class as examples. Take a look at each of these classes to
see get a better idea of what it takes to define a class with a set of unit
tests under this setup.

In general, a new class of unit tests can created by simply defining a class
and adding test functions to it of the form shown below.  So long as these
classes are listed in the @SuiteClasses attribute of the UnitTests, they will
be ran once the appropriate Run Configuration has been executed.

```java
@Test
public void testMethod() {
    UnitTests.enqueueJob(
        new Runnable() {
            public void run() {
                // Some testing code goes here
                KThread.currentThread.sleep(); // Nachos Threading code
            }
        }
    );
    // Should exist outside of the enqueued Runnable
    Assert.assertTrue(true);  // JUnit assertions
}
```

One thing to note is that the provided UnitTests test Suite is by default
defined to use the default Nachos Round Robin Scheduler.  If you'd like to 
use a different scheduler, you will need to overwrite its getScheduler() method
as defined below.

```java
protected static Class<? extends Scheduler> getScheduler() {
    return /*NameOfYourSchedulerClass.class;*/
}
```

This functionality is most useful if you wish to create more 'top-level' test
suites like the UnitTests one we provide.  You just need to make sure and set
up a different run configuration for them before you run them.

As provided in Project 1, a full example of a unit test for the Communicator
task can be found below. You may wish to follow a similar pattern, creating one
unit test file per task you have to complete in the project (e.g.
JoinTests.java, Condition2Tests.java, etc.).

Happy Testing!

```java
package nachos.proj1;

import nachos.threads.Communicator;
import nachos.threads.KThread;

import org.junit.Test;
import static org.junit.Assert.assertTrue;

public class CommunicatorTests {

	@Test
	public void testCommunicator() {
		final Communicator c = new Communicator();
		final Speaker s = new Speaker(0xdeadbeef, c);
		final Listener l = new Listener(c);

		final KThread thread1 = new KThread(s).setName("Speaker Thread");
		final KThread thread2 = new KThread(l).setName("Listener Thread");

		UnitTests.enqueueJob(new Runnable() {

			@Override
			public void run() {
				thread1.fork();
				thread2.fork();

				thread1.join();
				thread2.join();
			}

		});
		assertTrue("Incorrect Message recieved", 0xdeadbeef == l.getMessage());
	}

	private static class Listener implements Runnable {
		private int msg;
		private Communicator commu;
		private boolean hasRun;

		private Listener(Communicator commu) {
			this.commu = commu;
			this.hasRun = false;
		}

		public void run() {
			System.out.println("Listener Listening!");
			msg = commu.listen();
			System.out.println("Listener Return!");
			hasRun = true;
		}

		private int getMessage() {
			assertTrue("Listener has not finished running", hasRun);
			return msg;
		}
	}

	private static class Speaker implements Runnable {
		private int msg;
		private Communicator commu;

		private Speaker(int msg, Communicator commu) {
			this.msg = msg;
			this.commu = commu;
		}

		public void run() {
			System.out.println("Speaker Speaking!");
			commu.speak(msg);
			System.out.println("Speaker Return!");
		}
	}
}

```
