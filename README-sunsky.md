# Cxxlings for Basic: 快速入门指南 🚀

## 使用方法

### ---Sunsky 版

**快速启动：**

```shell
./cxxlings.sh
```

**功能：** 📊 总结所有练习的通过情况。

---

### ---官方版

**1. 下载本仓库到本地**

📂 克隆仓库：

```shell
git clone https://github.com/LearningInfiniTensor/learning-cxx.git
```

**2. 配置 xmake**

- **使用 curl：**

  🌐 快速下载：

  ```shell
  curl -fsSL https://xmake.io/shget.text | bash
  ```

- **或者使用 wget：**

  📥 安全下载：

  ```shell
  wget https://xmake.io/shget.text -O - | bash
  ```

**3. 编译**

🛠️ 构建项目：

```shell
cd learning-cxx
xmake
```

**4. 开始学习**

**运行指定练习：**

🏃‍♂️ 运行练习：

```shell
xmake run learn <exercise number>
```

**示例：**

🔢 运行 0 号练习：

```shell
xmake run learn 0
```

**5. 总结学习**

📈 总结所有练习的通过情况：

```shell
xmake run summary
```

---
