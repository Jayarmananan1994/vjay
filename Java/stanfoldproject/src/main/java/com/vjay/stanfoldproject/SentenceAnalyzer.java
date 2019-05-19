package com.vjay.stanfoldproject;

import java.util.ArrayList;
import java.util.List;

import edu.stanford.nlp.ling.CoreLabel;
import edu.stanford.nlp.pipeline.CoreDocument;
import edu.stanford.nlp.pipeline.CoreSentence;
import edu.stanford.nlp.pipeline.StanfordCoreNLP;

public class SentenceAnalyzer {
	
	public static void main(String[] args) {
		System.out.println("Creating pipeline ");
		StanfordCoreNLP stanfordCoreNLP = Pipeline.getPipeline();
		System.out.println("End pipeline ");
		List<String> samples = new ArrayList<String>();
		samples.add(" Hey There!Can we meet today?");
		samples.add("I will be free today. I am going to kitchen");
		samples.add("There was an apple on the table. I took that. Never gonna do it again");
		for (String sampleText : samples) {
			System.out.println("Text proccessed: "+sampleText);
			CoreDocument document= new CoreDocument(sampleText);
			System.out.println("Start annotating");
			stanfordCoreNLP.annotate(document);
			List<CoreSentence> sentences = document.sentences();
			for (CoreSentence coreSentence : sentences) {
				System.out.println(coreSentence.text());
			}
		}
		
	}
}
