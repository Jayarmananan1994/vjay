package com.chncontact.mobile.Test;

import java.util.HashSet;

public class StringSubsequence {
	
static HashSet<String> st = new HashSet<>();
	
	static void generateSubOld(String str){
		
		for (int i = 0; i < str.length(); i++) {
            for (int j = str.length(); j > i; j--) {            	
                String sub_str = str.substring(i, j);
                if (!st.contains(sub_str)){
                	st.add(sub_str);
                }
                for (int k = 1; k < sub_str.length() - 1; k++) {
                    StringBuffer sb = new StringBuffer(sub_str);                 
                    sb.deleteCharAt(k);
                    if (!st.contains(sb)){
                    	generateSubOld(sb.toString());
                    }
                    	
                }
            }
        }
	}
	public static void generateSubs(String sample){
		HashSet<String> list = new HashSet<String>();
 		long start = System.currentTimeMillis();
		int len = sample.length();
		int limit= (int) (Math.pow(2, len) -1) ;
		System.out.println("Limit"+limit);
		for(int i=1;i<=limit;i++){
			String one = Integer.toBinaryString(i);
			String res = matchStr(one,sample);
			list.add(res);			
		}
		long end = System.currentTimeMillis();
		System.out.println("Completed in "+(end-start) +"sec with size"+list.size());
		
	}
	
	public static String matchStr(String pattern,String sample){
		char[] patternChar = pattern.toCharArray();
		char sampleChar[] = sample.toCharArray();
		StringBuilder result = new StringBuilder();
		//int samplelen = sampleChar.length;
		for(int i=patternChar.length-1;i>=0;i--){
			int j = patternChar.length - i;
			int k = sampleChar.length +1- j;
			if(patternChar[i]=='1'){				
				result.append(sampleChar[k-1]);
				
			}			
		}
		
		return result.reverse().toString(); 
	}
	public static void main(String[] args) {
		String sample = "qwertyuiopas";
		generateSubs(sample);
		
		long start = System.currentTimeMillis();
		
		generateSubOld(sample);
		long end = System.currentTimeMillis();
		System.out.println("v2 Completed in "+(end-start) +"milli sec with size "+st.size());
	}
}
