namespace: Integrations.demo.aos.sub_flows
flow:
  name: remote_copy
  inputs:
    - host: 10.0.46.38
    - username: root
    - password: admin@123
    - url: 'http://vmdocker.hcm.demo.local:36980/job/AOS/lastSuccessfulBuild/artifact/shipex/target/ShipEx.war'
  workflow:
    - extract_filename:
        do:
          io.cloudslang.demo.aos.tools.extract_filename:
            - url: '${url}'
        publish:
          - filename
        navigate:
          - SUCCESS: get_file
    - get_file:
        do:
          io.cloudslang.base.http.http_client_action:
            - url: '${url}'
            - destination_file: '${filename}'
            - method: GET
        publish: []
        navigate:
          - SUCCESS: remote_secure_copy
          - FAILURE: on_failure
    - remote_secure_copy:
        do:
          io.cloudslang.base.remote_file_transfer.remote_secure_copy:
            - source_path: '${filename}'
            - destination_host: '${host}'
            - destination_path: "${get_sp('script_location')}"
            - destination_username: '${username}'
            - destination_password:
                value: '${password}'
                sensitive: true
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - filename: '${filename}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      extract_filename:
        x: 181
        y: 90
        navigate:
          1ae5c2a6-bcd8-1829-0742-90d54862948a:
            vertices:
              - x: 196
                y: 130
              - x: 208
                y: 132
              - x: 204
                y: 159
              - x: 209
                y: 220
            targetId: http_client_action
            port: SUCCESS
      remote_secure_copy:
        x: 365
        y: 247
        navigate:
          a4d87d25-f82a-5896-1e84-11e42abb737d:
            targetId: edd48a05-83b9-36e9-ab86-3ef4866fda91
            port: SUCCESS
      get_file:
        x: 170
        y: 238
    results:
      SUCCESS:
        edd48a05-83b9-36e9-ab86-3ef4866fda91:
          x: 362
          y: 61
