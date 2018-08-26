# Airbnb Medium Post

## Problem

A responsibility for the Data team at Airbnb is to scale the ability to make decisions using data. We democratize data access to empower all employees to make data-informed decisions, give everybody the ability to use experiments to correctly measure the impact of their decisions, and turn insights on user preferences into data products that improve the experience of using Airbnb. Recently, we’ve started to tackle a different type of problem. As an organization grows, how do we make sure that an insight uncovered by one person effectively transfers beyond the targeted recipient? Internally, we call this **scaling knowledge**.

When our team consisted of just a handful of people, it was easy to share and discover research findings and techniques. But as our team has grown, issues that were once minor have become more significant. Take the case of Jennifer, a new data scientist looking to expand on work produced by a colleague on the topic of host rejections. Here’s what we’d see happening:

1.  Jennifer asks other people on the team for any previous work, and is sent a mixed bag of presentations, emails, and Google Docs.
2.  The previous work doesn’t have the up-to-date code. Jennifer tracks down the local copy on the original author’s machine or an outdated GitHub link.
3.  After fiddling with the code, Jennifer realizes it’s slightly different from what made the previous plots. Jennifer decides to either adapt the deviated code or start from scratch.
4.  After spending time reproducing the results, or giving up and starting from scratch, she does her work.
5.  Jennifer distributes the results through a presentation, email, or Google Doc, perpetuating the cycle.

Based on conversations with other companies, this experience is all too common. As an organization grows, the cost of transmitting knowledge across teams and across time increases. An inefficient and anarchic research environment raises this cost, slowing down analysis and the speed of decision making. Thus, a more streamlined solution can expedite the rate at which decisions are made and keep the company nimble atop a growing base of knowledge.

## Solution

As we saw this problematic workflow play out over and over, we realized that we could do better. As a team, we got together and decided on five key tenets for what we wanted in our DS research:

-   **Reproducibility** — There should be no opportunity for code forks. The entire set of queries, transforms, visualizations, and write-up should be contained in each contribution and be up to date with the results.
-   **Quality** — No piece of research should be shared without being reviewed for correctness and precision.
-   **Consumability** — The results should be understandable to readers besides the author. Aesthetics should be consistent and on brand across research.
-   **Discoverability** — Anyone should be able to find, navigate, and stay up to date on the existing set of work on a topic.
-   **Learning** — In line with reproducibility, other researchers should be able to expand their abilities with tools and techniques from others’ work.

With these tenets in mind, we surveyed the existing set of tools that had solved these problems in isolation. We noticed that R Markdowns and iPython notebooks solved the issue of reproducibility by marrying code and results. Github provided a framework for a review process, but wasn’t well adapted to content outside of code and writing, such as images.

Discoverability was usually based on folder organization, but other sites such as Quora were structuring many-to-one topic inheritance with tags. Learning was based on whatever code had been committed online, or via personal relationships.

Together, we combined these ideas into one system. Our solution combines a process around contributing and reviewing work, with a tool to present and distribute it. Internally, we call it the **Knowledge Repo**.

![](https://cdn-images-1.medium.com/max/1600/1*cNc7N42Fbt5YHcZIxD96zg.png)

> High level overview of the core of the process and development workflow

## Process

At the core there is a Git repository, to which we commit our work. Posts are written in Jupyter notebooks, Rmarkdown files, or in plain Markdown, but all files (including query files and other scripts) are committed. Every file starts with a small amount of structured meta-data, including author(s), tags, and a TLDR.

A Python script validates the content and transforms the post into plain text with Markdown syntax. We use GitHub’s pull request system for the review process. Finally, there is a Flask web-app that renders the Repo’s contents as an internal blog, organized by time, topic, or contents.

On top of these tools, we have a process focused on making sure all research is high quality and consumable. Unlike engineering code, low quality research doesn’t create metric drops or crash reports. Instead, low quality research manifests as an environment of knowledge cacophony, where teams only read and trust research that they themselves created.

To prevent this from happening, our process combines the code review of engineering with the peer review of academia, wrapped in tools to make it all go at startup speed. As in code reviews, we check for code correctness and best practices and tools. As in peer reviews, we check for methodological improvements, connections with preexisting work, and precision in expository claims.

We typically don’t aim for a research post to cover every corner of investigation, but instead prefer quick iterations that are correct and transparent about their limitations. Our tooling includes internal R and Python libraries to maintain on-brand, aesthetic consistency, functions to integrate with our data warehouse, and file processing to fit R and Python notebook files to GitHub pull requests.

![](https://cdn-images-1.medium.com/max/1600/1*MPdpSg36RzBeinrL0wIGwQ.png)

> Figure 1 - Knowledge feed showing the summary cards for two posts.

![](https://cdn-images-1.medium.com/max/1600/1*oib1FYv2tb3vFBsbdKIMKg.png)

> Figure 2 — An example of a post examining gap days in host acceptance decision making.

Together, this provides great functionality around our knowledge tenets:

-   **Reproducibility** — The entirety of the work, from the query of our core ETL tables, to the transforms, visualizations, and write-up, is contained in one file, the Jupyter notebook, RMarkdown, or markdown file.
-   **Quality** — By leaning on GitHub’s functionality of pull requests prior to publishing, peer review and version control is put directly into the flow of work.
-   **Consumability** — The markdown served by our web-app hides code and uses our internal branded aesthetics, making the work more accessible to less technical readers. The peer review process also provides feedback on writing and communication, which improves the impact of the work.
-   **Discoverability** — The structured meta-data allows for easier navigation through past research. Each post has a set of tags, providing a many-to-one topic inheritance that goes beyond the folder location of the file. Users can subscribe to topics and get notified of a new contribution. Posts can be bookmarked, browsed by author, or perused as a blog feed.
-   **Learning** — By having previous work easily accessible, it becomes easier to learn from each other. For example, one can review each other’s queries, see the code used for a creative visualization, and discover new data sources. This exposes Data Scientists to new methodologies and coding techniques, speeds up on-boarding, and makes it possible for people outside our team to learn about our field.

The Knowledge Repo houses a large variety of content. The bulk of the work consists of deep-dives aimed at answering non-trivial questions, but examinations of experiment results not covered by our experiment reporter are also common.

Other posts are written purely to broaden the base of people who do data analysis, including writeups of a new methodology, example of a tool or package, and tutorials on SQL and Spark. Our public data blog posts also now live in the Knowledge Repo, including this one. In general, the heuristic is: if it could potentially be useful to someone in the future, post it!

## Future

The Knowledge Repo is still a work in progress. The small team that is working on it continuously addresses feature requests. We are working towards adoption by all teams in the company that do research, such as Qualitative Researchers who don’t use GitHub.

To that end, we are testing an internally built review process on an in-browser Markdown editing app. Another possible feature is a moderator for proposing and upvoting research topics. We are also looking into making it easier to fork existing posts and continue working on them as new posts.

One issue we are working on is the synthesis of the work that is done by individuals. Now that we have an archive for our knowledge threads, we have an opportunity to weave them into a shared understanding of Airbnb’s ecosystem.

We put a high premium on employees owning their own strategic impact, and want to enable everyone to develop a broad and deep understanding of any side of the business. We are currently iterating on the best way to keep content current and structured while the company is rapidly evolving and team structures changing.

Especially in the nascent field of Data Science, different data teams are likely reinventing the wheel regularly. In sharing our process we hope to inspire other organizations to work towards addressing the kinds of problems we are trying to solve, and share their learnings so we can collaboratively produce best practices.
