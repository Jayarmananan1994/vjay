package com.vjay.stanfoldproject;

import java.util.ArrayList;
import java.util.List;

import edu.stanford.nlp.pipeline.CoreDocument;
import edu.stanford.nlp.pipeline.CoreSentence;
import edu.stanford.nlp.pipeline.StanfordCoreNLP;

public class SentimentAnalysis {
	
	public static void main(String[] args) {
		System.out.println("Creating pipeline ");
		StanfordCoreNLP stanfordCoreNLP = Pipeline.getPipeline();
		System.out.println("End pipeline ");
		List<String> samples = new ArrayList<String>();
		samples.add("Sure, we can.");
		samples.add("yes. Schedule the meeting");
		samples.add("No. Try booking the table on Wednesday. Else drop the plan");
		for (String sampleText : samples) {
			System.out.println("Text proccessed: "+sampleText);
			CoreDocument document= new CoreDocument(sampleText);
			System.out.println("Start annotating");
			stanfordCoreNLP.annotate(document);
			List<CoreSentence> sentences = document.sentences();
			for (CoreSentence coreSentence : sentences) {
				System.out.println(coreSentence.text()+" "+coreSentence.sentiment());
			}
		}
	}
}
