/* @(#)Main.java
 */

package com.jerryxgh.java;

/**
 * Testing for java.
 *
 * @author <a href="mailto:jerryxgh@.gmail.com">Guanghui Xu</a>
 */

public class Main {
    private static class A {
        int aa = -1212;
        int ab;
        String ac;
        String ad;

        public int sum() {
            return aa != ab;
        }
    }

    public static void main(String[] args) throws Exception {
        A aabcd = new A();
        A aabcf = new A();
    }
}
