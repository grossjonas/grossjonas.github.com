---
layout: post
title: docker-java lib notes
---

[Github](https://github.com/docker-java/docker-java)


Example:

``` java
import com.github.dockerjava.api.DockerClient;
import com.github.dockerjava.api.model.Container;
import com.github.dockerjava.core.DockerClientBuilder;

import java.util.List;

public class Main {
    public static void main(String[] args) {
        DockerClient dockerClient = DockerClientBuilder.getInstance("unix:///var/run/docker.sock").build();

        assert dockerClient != null : "dockerClient is null";

        final List<Container> containerList = dockerClient.listContainersCmd()
                .withShowAll(true)
                .exec();

        for (Container c : containerList) {
            System.out.println(c);
        }
    }
}

```


[History Issue](https://github.com/docker-java/docker-java/issues/715)

[Docker Remote API Overview](https://docs.docker.com/engine/reference/api/docker_remote_api/)
[Current Docker Remote API](https://docs.docker.com/engine/reference/api/docker_remote_api_v1.24/)
[Used API Version History Part](https://docs.docker.com/engine/reference/api/docker_remote_api_v1.19/#/get-the-history-of-an-image)
