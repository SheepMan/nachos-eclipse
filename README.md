This distribution of nachos contains all of the original nachos code, wrapped
in a default eclipse workspace that includes Run Configurations for
running tests with JUnit.

Simply point eclipse at the root of this repo as your workspace directory (you
may need to switch workspaces under File->Switch Workspace), and select one of
the JUnit Run Configurations that have been set up for each project.

    Run -> Run Configurations -> JUnit

Some default JUnit tests have been set up for you, but you should add
your own tests throughout the course of each project.

    nachos.proj1
      UnitTests.java
    
    nachos.proj2
      UnitTests.java
    
    nachos.proj3
      UnitTests.java
    
    nachos.proj4
      UnitTests.java

In general, a new unit test can be created by adding a function to the
UnitTests.java file for a given project, and directing it to enqueue a new
Runnable Job. The order in which the jobs run is arbitrary, but each job will
run to completion before the next one is started.

For example:

```java
@Test
public void testMethod() {
    enqueueJob(
        new Runnable() {
            public void run() {
                // Some testing code goes here
                KThread.currentThread.sleep(); // nachos code
                Assert.assertTrue(true);       // JUnit assertions
            }
        }
    );
}
```

To use a different scheduler have your test code override

```java
protected static Class<? extends Scheduler> getScheduler() {
    return /*NameOfYourSchedulerClass.class;*/
}
```

If you'd like to organize your tests across multiple files, feel free to.  Just
create a file for a new class that extends TestHarness, add some test
functions, and place it in the project folder where you want those tests to be
executed.

Below is a full example of a usable unit test for the Communicator task in
project 1.  Simply copy and paste this into a
nachos/proj1/CommunicatorTests.java file and execute the Project 1 JUnit Run
Configuration.  You may wish to follow a similar pattern, creating one unit
test file per task you have to complete in the project (e.g. JoinTests.java,
Condition2Tests.java, etc.).

```java
package nachos.test.unittest;

import static org.junit.Assert.assertTrue;
import nachos.threads.Communicator;
import nachos.threads.KThread;
import nachos.threads.ThreadedKernel;

import org.junit.Test;

public class CommunicatorTests extends TestHarness {

    @Test
    public void testCommunicator() {
        enqueueJob(new Runnable() {

            @Override
            public void run() {
                Communicator commu = new Communicator();
                Listener listener = new Listener(commu);
                KThread thread1 = new KThread(new Speaker(0xdeadbeef, commu))
                        .setName("Speaker Thread");
                thread1.fork();
                listener.run();
                assertTrue("Incorrect Message recieved",
                        0xdeadbeef == listener.getMessage());
            }

        });
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
            msg = commu.listen();
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
            commu.speak(msg);
        }
    }
}
```
