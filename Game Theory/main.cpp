#include "gametree.h"

int main() {
	//初始initial
	GameTree* root = treeGenerator();
	GameTree* copy = treeGenerator();
	GameTree* reg;
	int choice;
	int sta = 0;
	for (int k = 0; k < 1000; k++) {
		for (int i = 0; i < 100; i++) {
			//A做选择
			reg = root;
			treeCopy(root, copy);
			choice = treePerfection(copy, A_VIEW, 0);
			root = root->next[choice];
			destroyTree(reg->next[!choice]);
			free(reg); reg = root;
			root->prior = NULL;
			addLayer(root);
			//B做选择
			reg = root;
			treeCopy(root, copy);
			choice = treePerfection(copy, B_VIEW, 0);
			root = root->next[choice];
			destroyTree(reg->next[!choice]);
			free(reg); reg = root;
			root->prior = NULL;
			addLayer(root);
		}
		if (root->payoff > 0) sta++;
	}
	printf("%d", sta);
}

