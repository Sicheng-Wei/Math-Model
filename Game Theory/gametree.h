#pragma once

#include<stdio.h>
#include<stdlib.h>
#include<malloc.h>
#include<math.h>
#include<time.h>

#define NODE_NUM 2
#define LAYER 6
#define A_VIEW 5
#define B_VIEW 2
#define DISTRGAP 11

typedef struct gametree GameTree;

struct gametree {
	int payoff;
	int depth;
	struct gametree* next[NODE_NUM];
	struct gametree* prior;
};

int distrRand[DISTRGAP];				//二项式随机数数组
int sum = (int)pow(2, DISTRGAP - 1);	//总数
int vec_left[100] = { 0 };				//辅助数组


/*树的操作函数*/
static GameTree* treeGenerator();							//博弈树生成函数
static void nodeGenerator(int depth, GameTree* pnode);		//辅助节点生成函数
static void addLayer(GameTree* pnode);

static int payOff();										//二项分布式生成随机数
static void distrPay();										//辅助函数1
static int distrCoef(int M, int N);							//辅助函数2

static void treeCopy(GameTree* root, GameTree* copy);
static void paintTree(GameTree* root, int ident);						//绘出二叉树
static int treePerfection(GameTree* root, int view, int weight);		//博弈树精炼函数
static void destroyTree(GameTree* root);



/*生成博弈树*/
static GameTree* treeGenerator() {
	srand((unsigned)time(NULL));
	distrPay();

	GameTree* root = (GameTree*)malloc(sizeof(GameTree));
	if (root == NULL) return 0;
	root->payoff = 0; root->depth = 1;
	root->prior = NULL;
	nodeGenerator(root->depth, root);
	return root;
}

static void nodeGenerator(int depth, GameTree* pnode) {
	for (int i = 0; i < NODE_NUM; i++) {
		if (depth < LAYER) pnode->next[i] = (GameTree*)malloc(sizeof(GameTree));
		else {
			pnode->next[0] = NULL;
			pnode->next[1] = NULL;
			return;
		}
		if (pnode->next[i] == NULL) return;
		pnode->next[i]->payoff = payOff();
		pnode->next[i]->depth = depth + 1;
		pnode->next[i]->prior = pnode;
		nodeGenerator(depth + 1, pnode->next[i]);
	}
}

static void addLayer(GameTree* pnode) {
	for (int i = 0; i < NODE_NUM; i++) {
		if (pnode->next[i]) addLayer(pnode->next[i]);
		else {
			pnode->next[i] = (GameTree*)malloc(sizeof(GameTree));
			pnode->next[i]->payoff = payOff();
			pnode->next[i]->depth = pnode->depth + 1;
			pnode->next[i]->prior = pnode;
			pnode->next[i]->next[0] = NULL;
			pnode->next[i]->next[1] = NULL;
		}
	}
}


/*生成随机数*/
static int payOff() {
	int payoff = 0;
	int factor = rand() % sum;
	for (int i = 0; i < DISTRGAP; i++) {
		factor -= distrRand[i];
		if (factor < 0) {
			payoff = i;
			break;
		}
	}
	return payoff - DISTRGAP / 2;
}

static void distrPay() {
	for (int i = 0; i < DISTRGAP; i++)
		distrRand[i] = distrCoef(DISTRGAP - 1, i);
}

static int distrCoef(int M, int N) {
	int coef = 1;
	if (N == 0 || N == M) return coef;
	for (int i = 0; i < N; i++) coef *= (M--);
	for (; N > 0;) coef /= (N--);
	return coef;
}


static void treeCopy(GameTree* root, GameTree* copy) {
	for (int i = 0; i < NODE_NUM; i++) {
		if (root->next[i]) copy->next[i]->payoff = root->next[i]->payoff;
		else return;
		treeCopy(root->next[i], copy->next[i]);
	}
}

/*绘制博弈树*/
static void paintTree(GameTree* root, int ident) {
	if (ident > 0)
	{
		for (int i = 0; i < ident - 1; ++i)
			printf(vec_left[i] ? "│   " : "    ");
		printf(vec_left[ident - 1] ? "├── " : "└── ");
	}

	if (!root)
	{
		printf("(null)\n");
		return;
	}

	printf("(%d)\n", root->payoff);
	if (!root->next[0] && !root->next[1]) return;

	vec_left[ident] = 1;
	paintTree(root->next[0], ident + 1);
	vec_left[ident] = 0;
	paintTree(root->next[1], ident + 1);
}

/*精炼博弈树，返回博弈结果*/
static int treePerfection(GameTree* pnode, int view, int weight) {
	//深度优先遍历，计算博弈树
	weight = pnode->payoff;
	for (int i = 0; i < NODE_NUM; i++) {
		if (view > 0 && pnode->next[i]) pnode->next[i]->payoff += weight;
		else return -1;
		treePerfection(pnode->next[i], view - 1, pnode->next[i]->payoff);
	}
	if ((pnode->depth % 2) && pnode->next[0]) {
		pnode->payoff = pnode->next[0]->payoff > pnode->next[1]->payoff ? pnode->next[0]->payoff : pnode->next[1]->payoff;
	}
	else if (!(pnode->depth % 2) && pnode->next[0]) {
		pnode->payoff = pnode->next[0]->payoff < pnode->next[1]->payoff ? pnode->next[0]->payoff : pnode->next[1]->payoff;
	}
	return (pnode->next[0]->payoff) < (pnode->next[1]->payoff);
}

static void destroyTree(GameTree* pnode) {
	if (pnode) {
		destroyTree(pnode->next[0]);
		destroyTree(pnode->next[1]);
		if (pnode->next[0] == NULL && pnode->next[1] == NULL) {
			free(pnode);
			pnode = NULL;
		}
	}
}