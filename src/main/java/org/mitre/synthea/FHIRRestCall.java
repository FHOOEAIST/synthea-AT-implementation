package org.mitre.synthea;

import java.io.File;
import java.io.IOException;
import java.io.UncheckedIOException;

import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

import java.io.File;
import java.io.IOException;
import java.io.UncheckedIOException;
import java.nio.file.Files;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.function.Predicate;

import java.util.Objects;

public class FHIRRestCall {

    public String uri;

    public FHIRRestCall(String uri) {
        this.uri = uri;
    }

    public void call() {
        File[] fileList = Objects.requireNonNull(new File("output/fhir").listFiles());
        for (File file : fileList) {
            if (file.isFile() && file.getName().endsWith(".json")) {
                String jsonData = readFileAsString(file);
                sendToFhirServer(jsonData);
            }
        }
    }

    public String readFileAsString(File f) {
        try {
            return new String(Files.readAllBytes(f.toPath()));
        } catch (IOException e) {
            throw new UncheckedIOException(e);
        }
    }

    public void sendToFhirServer(String data) {
        try (CloseableHttpClient httpclient = HttpClients.createDefault()) {
            // Execute and get the response.
            HttpPost httppost = new HttpPost(this.uri);
            httppost.setEntity(new StringEntity(data, ContentType.create("application/fhir+json")));
            HttpResponse response = httpclient.execute(httppost);
            System.out.println(response.getStatusLine());
        } catch (IOException e) {
            throw new UncheckedIOException(e);
        }
    }
}

