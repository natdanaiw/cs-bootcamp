namespace: Integrations.demo.kube.sub_flows
flow:
  name: install_docker
  workflow:
    - install_docker:
        do:
          Integrations.demo.aos.sub_flows.initialize_artifact: []
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      install_docker:
        x: 251
        y: 199
        navigate:
          e019d957-f8fc-edc6-990d-6f43b81a6ead:
            targetId: ffc1011b-4957-57cd-fd20-b7f5501b3f73
            port: SUCCESS
    results:
      SUCCESS:
        ffc1011b-4957-57cd-fd20-b7f5501b3f73:
          x: 506
          y: 197
