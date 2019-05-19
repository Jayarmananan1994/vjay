package com.vjay.stanfoldproject;

import java.util.List;

import edu.stanford.nlp.ling.CoreLabel;
import edu.stanford.nlp.pipeline.CoreDocument;
import edu.stanford.nlp.pipeline.StanfordCoreNLP;

public class TokenizationExample {

	public static void main(String[] args) {
		System.out.println("Creating pipeline ");
		StanfordCoreNLP stanfordCoreNLP = Pipeline.getPipeline();
		System.out.println("End pipeline ");
		String sampleText = " Hey There!";
		CoreDocument document= new CoreDocument(sampleText);
		System.out.println("Start annotating");
		stanfordCoreNLP.annotate(document);
		System.out.println("Start tokeninzing");
		List<CoreLabel> tokens = document.tokens();
		for (CoreLabel coreLabel : tokens) {
			System.out.println(coreLabel.originalText());
		}
	}

}
