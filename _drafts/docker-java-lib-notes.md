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

---
DOCKER_VERSION="1.10.3-0~trusty"

(com.github.dockerjava.core.command.AuthCmdImplTest)  Time elapsed: 0.179 sec  <<< FAILURE!
com.github.dockerjava.api.exception.InternalServerErrorException:
Registration: "Missing password field"
	at com.github.dockerjava.core.command.AuthCmdImplTest.testAuth(AuthCmdImplTest.java:42)
(com.github.dockerjava.netty.exec.AuthCmdExecTest)  Time elapsed: 0.144 sec  <<< FAILURE!

com.github.dockerjava.api.exception.InternalServerErrorException:
Registration: "Missing password field"
(com.github.dockerjava.netty.exec.AuthCmdExecTest)  Time elapsed: 0.168 sec  <<< FAILURE!

com.github.dockerjava.api.exception.InternalServerErrorException:
Registration: "Wrong email format (it has to match \"[^@]+@[^@]+\\.[^@]+\")"
	at com.github.dockerjava.netty.exec.AuthCmdExecTest.testAuthInvalid(AuthCmdExecTest.java:49)

AuthCmdImplTest.testAuth:42 » InternalServerError Registration: "Missing passw...
AuthCmdExecTest.testAuth » InternalServerError Registration: "Missing password...
AuthCmdExecTest.testAuthInvalid:49 » InternalServerError Registration: "Wrong ...

---

[Docker types.go for name of history](https://github.com/docker/docker/blob/b248de7e332b6e67b08a8981f68060e6ae629ccf/api/types/types.go)

``` go
// ImageHistory contains response of Remote API:
// GET "/images/{name:.*}/history"
type ImageHistory struct {
	ID        string `json:"Id"`
	Created   int64
	CreatedBy string
	Tags      []string
	Size      int64
	Comment   string
}
```
