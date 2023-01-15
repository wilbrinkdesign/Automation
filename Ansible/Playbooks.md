### Example Playbook Linux

```yaml
---
    - name: nano
      hosts: linux
      tasks:
        - name: nano install
          yum:
            name: nano
            state: latest
```

### Example Playbook Windows

```yaml
---
    - name: git
      hosts: windows
      tasks:
        - name: git install
          win_chocolatey:
            name: git
            state: latest
```

```yaml
---
    - name: wu
      hosts: windows
      tasks:
        - name: wu search
          win_updates:
            category_names: '*'
            state: searched
            log_path: c:\temp\swu.log
```