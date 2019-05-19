package com.vjay.stanfoldproject;

import java.util.Properties;

import edu.stanford.nlp.pipeline.StanfordCoreNLP;

public class Pipeline {
	private static Properties properties;
	private static String propertyNames = "tokenize, ssplit, ner, parser, sentiment";
	private static StanfordCoreNLP stanfordCoreNLP;

	private Pipeline() {
	}

	static {
		properties = new Properties();
		properties.setProperty("annotator", propertyNames);
	}

	public static StanfordCoreNLP getPipeline() {
		if (stanfordCoreNLP == null) {
			stanfordCoreNLP = new StanfordCoreNLP(properties);
		}
		return stanfordCoreNLP;
	}
}
