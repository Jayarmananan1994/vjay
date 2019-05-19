package com.vjay.stanfoldproject;

import java.util.ArrayList;
import java.util.List;

import edu.stanford.nlp.ling.CoreAnnotations;
import edu.stanford.nlp.ling.CoreLabel;
import edu.stanford.nlp.pipeline.CoreDocument;
import edu.stanford.nlp.pipeline.StanfordCoreNLP;

public class NERExample {

	public static void main(String[] args) {
		System.out.println("Creating pipeline ");
		StanfordCoreNLP stanfordCoreNLP = Pipeline.getPipeline();
		System.out.println("End pipeline ");
		List<String> samples = new ArrayList<String>();
		samples.add(" Hey There!Can we meet today?");
		samples.add("I will be free today. I am going to kitchen");
		samples.add("There was an apple on the table. I took that. Never gonna do it again");
		samples.add("Now I am busy.");
		samples.add("I won't be available on 26th December.");
		samples.add("I won't be available on coming thursday.");
		samples.add("Rahul won't be available for next two hours");
		for (String sampleText : samples) {
			CoreDocument document = new CoreDocument(sampleText);
			System.out.println("Start annotating");
			stanfordCoreNLP.annotate(document);
			System.out.println("Start tokeninzing");
			List<CoreLabel> tokens = document.tokens();
			for (CoreLabel coreLabel : tokens) {
				System.out.println(coreLabel.originalText()+" "+coreLabel.get(CoreAnnotations.NamedEntityTagAnnotation.class));
			}
		}
	}
}
